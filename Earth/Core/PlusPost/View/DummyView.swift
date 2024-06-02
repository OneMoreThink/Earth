//
//  MockView.swift
//  Earth
//
//  Created by 이종선 on 4/11/24.
//

import SwiftUI

struct DummyView: View {
    
    @Binding var showNewPostModal: Bool
    @State private var showingPermissionAlert = false
    
    var body: some View {
        ZStack{
            Color.princeYellow.ignoresSafeArea()
        }
        .onAppear{
            checkPermissions()
        }
        .alert(isPresented: $showingPermissionAlert){
            Alert(
                title: Text("권한 필요"),
                message: Text("생존 일지를 남기기 위해서는 카메라 및 마이크 권한이 필요합니다. 설정에서 권한을 허용해주세요"),
                primaryButton: .default(Text("설정으로 이동"), action: openAppSettings),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .fullScreenCover(isPresented: $showNewPostModal){
            RecordingView(showNewPostModal: $showNewPostModal)
                .ignoresSafeArea()

        }

    }
    
    private func checkPermissions() {
        PermissionManager.checkCameraPermission { cameraStatus in
            if cameraStatus == .authorized {
                PermissionManager.checkMicrophonePermission { microphoneStatus in
                    if microphoneStatus != .authorized {
                        showingPermissionAlert = true
                    } else {
                        showNewPostModal = true
                    }
                }
            } else {
                showingPermissionAlert = true
            }
        }
    }
    
    
    
    private func openAppSettings(){
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) , UIApplication.shared.canOpenURL(settingUrl) else {
            return
        }
        UIApplication.shared.open(settingUrl)
    }
}

#Preview {
    DummyView(showNewPostModal: .constant(false))
}
