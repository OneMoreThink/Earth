//
//  PermissionsManager.swift
//  Earth
//
//  Created by 이종선 on 4/11/24.
//

import Foundation
import AVFoundation

class PermissionManager {
    
    static func checkCameraPermission(completion: @escaping (AVAuthorizationStatus) -> Void){
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion( granted ? .authorized : .denied)
                }
            }
        default:
            completion(AVCaptureDevice.authorizationStatus(for: .video))
        }
    }
    
    static func checkMicrophonePermission(completion: @escaping (AVAuthorizationStatus) -> Void){
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async {
                    completion( granted ? .authorized : .denied)
                }
            }
        default:
            completion(AVCaptureDevice.authorizationStatus(for: .audio))
        }
    }
    
}
