//
//  Home.swift
//  Earth
//
//  Created by 이종선 on 11/14/23.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        
        ZStack{
            Color.black.opacity(0.03).ignoresSafeArea()
            NavigationView{
                VStack{
                    
                    InfoCardView()
                    
                    Divider()
                    
                    
                    // Calender
                    
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                    }
                }

            }
        }
    }
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View {
        HomeView()
    }
}
