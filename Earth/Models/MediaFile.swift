//
//  MediaFile.swift
//  Earth
//
//  Created by 이종선 on 11/30/23.
//

import SwiftUI

// Sample Model and Reels Videos

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var MediatFileJSON = [
    MediaFile(url: "Reelvideo-7599", title: "Are you princess"),
    MediaFile(url: "Reelvideo-11641", title: "bat flip"),
    MediaFile(url: "Reelvideo-20211", title: "mad duck"),
    MediaFile(url: "Reelvideo-30118", title: "three bears")

]
