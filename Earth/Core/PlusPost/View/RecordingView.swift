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
                    .padding(.bottom, 12)
                })
                    
                
            }
            
            
        }
        // MARK: 현재 cameraVm.alert에 접근하여 제어하는 요소가 없음
        .alert(isPresented: $cameraVm.alert){
            Alert(
                title: Text("카메라와 마이크 권한이 없습니다"),
                message: Text("영상일지를 남기기 위해서 설정에서 권한을 주세요"),
                dismissButton: .default(Text("OK")))
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
