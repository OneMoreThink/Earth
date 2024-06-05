//
//  PostHostingController.swift
//  Earth
//
//  Created by 이종선 on 6/5/24.
//

import SwiftUI

struct PostHostingController: UIViewControllerRepresentable {
    let post: Post
    
    func makeUIViewController(context: Context) -> some CustomHostingController<PostView> {
        let controller = CustomHostingController(rootView: PostView(post: post))
        controller.onDisappearAction = {
            print("PostView will disapper")
            if let player = post.player {
                player.pause()
            }
        }
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
