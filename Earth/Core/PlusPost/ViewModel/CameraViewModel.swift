//
//  CameraViewModel.swift
//  Earth
//
//  Created by 이종선 on 4/11/24.
//

import SwiftUI
import AVFoundation

class CameraViewModel: NSObject, ObservableObject {
    
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isRecording = false
    @Published var isLoading = false
    let postService = PostService.shared
    
    
    override init(){
        super.init()
        self.configureSession()
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveDataReloadNotification(_:)),
                         name: .didReloadPosts, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReloadPosts, object: nil)
    }
    
    @objc private func didReceiveDataReloadNotification(_ notification: Notification){
        self.isLoading = false
    }
    
    
    
    // 카메라 및 마이크 설정
    private func configureSession(){
        
        session.beginConfiguration()
        
        // 비디오 입력 설정
        if let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
           let videoInput = try? AVCaptureDeviceInput(device: cameraDevice),
           session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }
        
        // 오디오 입력 설정
        if let audioDevice = AVCaptureDevice.default(for: .audio),
           let audioInput = try? AVCaptureDeviceInput(device: audioDevice),
           session.canAddInput(audioInput){
            session.addInput(audioInput)
        }
        
        // 출력 설정
        if session.canAddOutput(output){
            session.addOutput(output)
        }
        
        // 미리보기 레이어 설정
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        
        session.commitConfiguration()
        
        }
    
    func activateSession(){
        DispatchQueue.global(qos: .userInitiated).async{
            self.session.startRunning()
        }
    }
    
    func startRecording(){
        AudioServicesPlaySystemSound(SystemSoundID(1113))
        DispatchQueue.main.async{
            guard !self.isRecording else {return}
            let outputPath = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mov")
            self.output.startRecording(to: outputPath, recordingDelegate: self)
            self.isRecording = true
        }
    }
    
    func stopRecording(){
        AudioServicesPlaySystemSound(SystemSoundID(1114))
        DispatchQueue.main.async{
            guard self.isRecording else {return}
            self.output.stopRecording() // output.stopRecording이 delegate의 fileOutput을 호출 
            self.isRecording = false
        }
    }
}
    
    
extension CameraViewModel: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        // 녹화 시작 처리
        print("녹화를 시작합니다")
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        // 녹화 완료 처리
        postService.createNewPost(from: outputFileURL, to: outputFileURL.lastPathComponent)
        // text method
        //postService.createNewPostWithRandomDate(from: outputFileURL, to: outputFileURL.lastPathComponent)
        print("녹화를 종료합니다")
    }
}

    

