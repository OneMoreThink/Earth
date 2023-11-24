//
//  ProgressBar.swift
//  Earth
//
//  Created by 이종선 on 11/24/23.
//

import SwiftUI

struct ProgressBar: ProgressViewStyle {
    
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.clear)
                .frame(height: 20.0)
            
            ProgressView(configuration)
                .tint(color)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
            .progressViewStyle(ProgressBar(color: .yellow))
            .previewLayout(.sizeThatFits)
    }
}
