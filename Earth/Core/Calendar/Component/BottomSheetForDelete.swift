//
//  BottomSheetForDelete.swift
//  Earth
//
//  Created by 이종선 on 7/6/24.
//

import SwiftUI

struct BottomSheetForDelete: View {
    
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(.red)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(height: 300)
    }
}

#Preview {
    BottomSheetForDelete(isSheetPresented: .constant(true))
}
