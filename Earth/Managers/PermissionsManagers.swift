//
//  PermissionsManagers.swift
//  Earth
//
//  Created by 이종선 on 11/21/23.
//

import Photos
import AVFoundation

class PermissionsManagers {
    
    // MARK: Check Photo Library Permission
    /** 권한 요청 처리 Flow
     아직 권한에 대한 세팅을 유저가 안한 경우 먼저 권한을 요청하고
     (권한 요청시 메인쓰레드에서 백그라운드로 제어권 넘어감)
     백그라운드에서 권한요청 결과값 받은 후 해당 결과값에 대한 처리(클로저)를 메인쓰레드에서 진행
     */
    static func checkPhotoLibraryPermission(completion: @escaping (PHAuthorizationStatus) -> ()){
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
           
            PHPhotoLibrary.requestAuthorization{ newStatus in
                DispatchQueue.main.async {
                    completion(newStatus)
                }
            }
        default:
            completion(status)
            
        }
    }
    
    
    // MARK: Check Camera Permission
    static func checkCameraPermission(completion: @escaping (AVAuthorizationStatus) -> ()){
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        default:
            completion(status)
        }
    }
    
    
    // MARK: Check Microphone Permission
    static func checkMicrophonePermission(completion: @escaping (AVAuthorizationStatus) -> ()){
        
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async{
                    completion(granted ? .authorized : .denied)
                }
            }
        default:
            completion(status)
        }
    }
    
}
