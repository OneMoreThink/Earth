//
//  CustomHostingController.swift
//  Earth
//
//  Created by 이종선 on 6/5/24.
//

import SwiftUI
import AVKit

class CustomHostingController<Content:View>: UIHostingController<Content>{
    
    var onDisappearAction: (()->Void)? 
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        onDisappearAction?()
    }
}
