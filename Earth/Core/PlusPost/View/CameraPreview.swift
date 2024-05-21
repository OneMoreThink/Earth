//
//  CameraPreview.swift
//  Earth
//
//  Created by 이종선 on 4/12/24.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var cameraVm: CameraViewModel
    var size: CGSize
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        
        cameraVm.preview.frame.size = size
        view.layer.addSublayer(cameraVm.preview)
        
        DispatchQueue.global(qos: .userInitiated).async {
            cameraVm.activateSession()
        }

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

