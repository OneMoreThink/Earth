//
//  ReelsView.swift
//  Earth
//
//  Created by 이종선 on 11/30/23.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    
    @State var currentReel = ""
    
    // Extracting AvPlayer from media File
    @State var reels = MediatFileJSON.map{ item -> Reel in
        
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: item)
    }
    
    var body: some View {
        
        // Setting Width and Height for rotated view
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            // Vertical Page Tab View
            TabView(selection: $currentReel) {
                
                ForEach($reels) { $reel in
                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
                    .frame(width: size.width)
                    .padding()
                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                    .tag(reel.id)
                    
                }
            }
            .rotationEffect(.init(degrees: 90))
            // Since view is rotated setting height as width
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            // setting max width
            .frame(width: size.width)
            
        }
        .ignoresSafeArea(.all, edges: .top)
        // setting intial reel
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsPlayer: View {
    
    @Binding var reel: Reel
    
    @Binding var currentReel: String
    
    // Expanding title if its clicked
    @State var showMore = false
    
    @State var isMuted = false
    @State var volumeAnimation = false
    
    var body: some View {
       
        ZStack{
            
            if let player = reel.player{
                
                CustomVideoPlayer(player: player)
                
                // Playing Video Based on Offset..
                
                GeometryReader{proxy -> Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        
                        // since we have many cards and offset goes beyond
                        // so it starts playing the below videos.
                        // to avoid this checking the current one with current reels id
                        
                        if -minY < (size.height / 2) && minY < (size.height / 2) && (currentReel == reel.id){
                            player.play()
                        }
                        else {
                            player.pause()
                        }
                    }
                    
                    
                    
                    return Color.clear
                }
                
                // Volume Control
                Color.black
                    .opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if volumeAnimation{
                            return
                        }
                        
                        isMuted.toggle()
                        player.isMuted = isMuted
                        withAnimation{volumeAnimation.toggle()}
                        
                        // Closing animation after 0.8 sec
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            withAnimation{volumeAnimation.toggle()}
                        }
                    }
                
                
                Color.black.opacity(showMore ? 0.35 : 0)
                    .onTapGesture {
                        withAnimation {showMore.toggle()}
                    }

                
                VStack(alignment: .leading, spacing: 10){
                    
                    HStack(alignment: .bottom){
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            HStack(spacing: 15){
                                
                                Image("idiot")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                
                                Text("Idiot")
                                    .font(.headline)
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    
                                    Text("Follow")
                                        .font(.caption.bold())
                                        .foregroundStyle(.black)
                                })
                                
                            }
                            
                            ZStack{
                                
                                if showMore{
                                    
                                    ScrollView(.vertical, showsIndicators: false){
                                        
                                        
                                        Text(reel.mediaFile.title + " " + sampleText )
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height: 120)
                                    .onTapGesture {
                                        withAnimation {showMore.toggle()}
                                    }
                                 
                                }
                                else{
                                    Button(action: {
                                        
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                        
                                    }, label: {
                                        HStack{
                                            
                                            Text(reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)
                                            
                                            Text("more")
                                                .font(.callout.bold())
                                                .foregroundStyle(.secondary)
                                        }
                                        .padding(.top, 5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    })
                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        // List of Buttons ...
                        ActionButtons(reel: reel)
                    }
                    
                    // Music View

                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .foregroundStyle(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                    
                
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .opacity(volumeAnimation ? 1 : 0)
            }
        }
    }
}

struct ActionButtons: View {
    var reel: Reel
    
    var body: some View {
        VStack(spacing: 25){
            
            Button(action: {
                
            }, label: {
                VStack(spacing: 10){
                    
                    Image(systemName: "heart")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("233K")
                        .font(.caption.bold())
                    
                }
            })
            
            Button(action: {
                
            }, label: {
                VStack(spacing: 10){
                    
                    Image(systemName: "bubble")
                        .font(.title)
                    
                    Text("233K")
                        .font(.caption.bold())
                    
                }
            })
            
            Button(action: {
                
            }, label: {
                VStack(spacing: 10){
                    
                    Image(systemName: "paperplane")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("233K")
                        .font(.caption.bold())
                    
                }
            })
            
            Button(action: {
                
            }, label: {
                VStack(spacing: 10){
                    
                    Image(systemName: "ellipsis.circle")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("233K")
                        .font(.caption.bold())
                    
                }
            })
        }
    }
}


struct ReelsView_Previews: PreviewProvider {
    
    static var previews: some View{
        ReelsView()
    }
}

let sampleText = "I'm publishing and graphic design books, This is my placeholder, without relying so many words I need,  Apple AirTag Wow This is my earth Lorem so many Wow I don't know How to work out that work out. Hello, My name is jonson I'm been trying to learn new things That is very happy weelllelelle I'm publishing and graphic design books, This is my placeholder, without relying so many words I need,  Apple AirTag Wow This is my earth Lorem so many Wow I don't know How to work out that work out. Hello, My name is jonson I'm been trying to learn new things That is very happy weelllelelle"
