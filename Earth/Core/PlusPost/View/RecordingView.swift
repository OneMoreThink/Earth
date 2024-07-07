//
//  RecordingView.swift
//  Earth
//
//  Created by 이종선 on 4/11/24.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    
    @Binding var showNewPostModal: Bool 
    @StateObject var cameraVm = CameraViewModel()
    
    var body: some View {
        
        ZStack {
        
            GeometryReader{ proxy in
                
                CameraPreview(cameraVm: cameraVm, size: proxy.size)

            }
            
            VStack{
                
                HStack{
                    Button(action: {
                        if cameraVm.isRecording{
                            cameraVm.isRecording = false
                        }
                        showNewPostModal = false
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 32, weight: .bold))
                            .padding(8)
                            .background(.black.opacity(0.001))
                            .foregroundStyle(.white.opacity(0.8))
                            
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .padding()
                .padding(.top, 32)
                
                Spacer()
                
                Button(action: {
                    toggleRecording()
                }, label: {
                    ZStack{
                            
                        if cameraVm.isRecording {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 32, height: 32)
                            
                        } else {
                            Circle()
                                .frame(width: 64, height: 64)
                        }
                    }
                    .foregroundStyle(.red)
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 4)
                            .frame(width: 72, height: 72)
                    )
                    .frame(height: 58)
                    .padding(.bottom, 40)
                    .animation(.easeInOut(duration: 0.3), value: cameraVm.isRecording)
                })
                    
                
            }
            
            
        }
        .onChange(of: cameraVm.isLoading) { newValue in
            if !newValue {
                showNewPostModal = false
            }
        }
    }
    
    
    private func toggleRecording(){
        if cameraVm.isRecording {
            cameraVm.stopRecording()
            cameraVm.isLoading = true
        } else {
            cameraVm.startRecording()
        }
    }
    
    
}

#Preview {
    ZStack{
        
        Color.black.ignoresSafeArea()
        
        RecordingView(showNewPostModal: .constant(false), cameraVm: CameraViewModel())
    }
}
