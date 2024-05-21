//
//  AudioSessionManager.swift
//  Earth
//
//  Created by 이종선 on 5/21/24.
//

import AVFoundation

class AudioSessionManager {
    static let shared = AudioSessionManager()
    
    private init() {
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
}
