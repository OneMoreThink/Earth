//
//  Reels.swift
//  Earth
//
//  Created by 이종선 on 12/4/23.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
