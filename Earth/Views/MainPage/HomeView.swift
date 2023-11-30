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
            
            VStack{
                
                InfoCardView()
                    
                
                Divider()
                
                CalendarView()
                    
                
            }
            
            
                
            
        }
    }
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View {
        HomeView()
    }
}
