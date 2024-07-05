//
//  TempView.swift
//  Earth
//
//  Created by 이종선 on 7/4/24.
//

import SwiftUI

struct TempView: View {
    
    var body: some View {
        
        
        GeometryReader{
            let size = $0.size
            ZStack{
                VStack{
                    SeekVideoPlayer(size: size)
                        .ignoresSafeArea()
                }
                
            }
        }
    }
}

#Preview {
    
    TempView()
    
}
