//
//  CustomVideoPlayer.swift
//  Earth
//
//  Created by 이종선 on 7/4/24.
//

import SwiftUI
import AVFoundation

struct SeekVideoPlayer: View {
    
    var size: CGSize
    
    //MARK: sample video 제거
    @State private var player: AVPlayer? = {
        if let bundle = Bundle.main.path(forResource: "Sample Video", ofType: "mp4"){
            return .init(url: URL(fileURLWithPath: bundle))
        }
        return nil
    }()
    
    
    @State private var showPlayerControls: Bool = false
    @State private var isPlaying: Bool = false
    @State private var isFinishedPlaying: Bool = false
    @State private var timeoutTask: DispatchWorkItem?
    
    
    /// Properties for VideoSeekers
    @GestureState private var isDragging: Bool = false
    @State private var isSeeking: Bool = false
    @State private var progress: CGFloat = 0
    @State private var lastDraggedProgress: CGFloat = 0
    @State private var isObserverAdded: Bool = false
    
    @State private var playerStatusObserver: NSKeyValueObservation?
    
    
    var body: some View {
        
        VStack(spacing: 0){
            let videoPlayerSize: CGSize = .init(width: size.width, height: size.height)
            
            // CustomVideoPlayerWithSeeker
            ZStack{
                if let player {
                    TempVideoPlayer(player: player)
                        .overlay(
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .opacity(showPlayerControls || isDragging ? 1 : 0)
                                .animation(.easeInOut(duration: 0.35), value: isDragging)
                                .overlay{
                                    PlayerBackControls()
                                }
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)){
                                showPlayerControls.toggle()
                            }
                            
                            if isPlaying {
                                timeoutControls()
                            }
                        }
                        .overlay(alignment: .bottom){
                            VideoSeekerView(videoPlayerSize)
                        }
                }
            }
            
        }
        // MARK: 제거 필요
        .padding(.vertical, 60)
        .padding(.horizontal, 24)
        .onAppear{
            guard !isObserverAdded else {return}
           
            player?.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 600), queue: .main, using: { time in
                
                if let currentPlayerItem = player?.currentItem {
                    
                    let totalDuration = currentPlayerItem.duration.seconds // 전체시간
                    guard let currentDuration = player?.currentTime().seconds else {return} // 재생된 시간
                    
                    let calculatedProgress = currentDuration / totalDuration
                    
                    if !isSeeking {
                        progress = calculatedProgress
                        lastDraggedProgress = progress
                    }
                    
                    if calculatedProgress == 1 {
                        isFinishedPlaying = true
                        isPlaying = false
                    }
                    
                }
            })
           isObserverAdded = true
        }
        .onDisappear{
           
            playerStatusObserver?.invalidate()
        }

    }
    
    
    
    @ViewBuilder
    func PlayerBackControls() -> some View{
        
        HStack(alignment:.center){
            
            Button(action: {
            
                if isFinishedPlaying {
                    // Setting Video to start and playing again
                    isFinishedPlaying = false
                    player?.seek(to: .zero)
                    progress = .zero
                    lastDraggedProgress = .zero
                }
               
                
                // 재생중인 경우 : 일시정지 버튼
                if isPlaying {
                    // Pause Video
                    player?.pause()
                    // Cancelling Timeout Task when the video is Paused
                    if let timeoutTask {
                        timeoutTask.cancel()
                    }
                    
                    // 멈춰있는 경우 : 재생 버튼
                } else {
                    // Play Video
                    // Video를 play하면 자동으로 controlls가 내려가도록
                    // timeout을 통해 설정
                    player?.play()
                    timeoutControls()
                }
                
                withAnimation(.easeInOut(duration: 0.2)){
                    isPlaying.toggle()
                }
                
            }, label: {
                
                // 종료되었을때 : 종료되지 않았을 때 (재생중일때 : 정지중일때)
                Image(systemName: isFinishedPlaying ? "arrow.clockwise" : ( isPlaying ? "pause.fill" : "play.fill"))
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(15)
                    .background{
                        Circle()
                            .fill(.black.opacity(0.4))
                    }
                    .scaleEffect(1.1)
            })
            
        }
        .opacity(showPlayerControls && !isDragging ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: showPlayerControls && !isDragging)
        
    }
    
    @ViewBuilder
    func VideoSeekerView( _ videoSize: CGSize) -> some View {
        ZStack(alignment: .leading){
            // 
            Rectangle()
                .fill(.gray)
            Rectangle()
                .fill(.princeYellow)
                .frame(width: max(videoSize.width * progress, 0))
        }
        .frame(height: 3)
        .overlay(alignment: .leading){
            Circle()
                .fill(.princeYellow)
                .frame(width: 15, height: 15)
                .scaleEffect(showPlayerControls || isDragging ? 1 : 0.001, anchor: progress * videoSize.width > 15 ? .center : .leading)
                .frame(width: 50, height: 50)
                .contentShape(Rectangle())
                .offset(x: videoSize.width * progress)
                .gesture(
                    DragGesture()
                        .updating($isDragging, body: { _, out, _ in
                            out = true
                        })
                        .onChanged({ value in
                            
                            // Cancelling Existing Timeout Task
                            if let timeoutTask {
                                timeoutTask.cancel()
                            }
                            
                            let translationX: CGFloat = value.translation.width
                            let calculatedProgress = (translationX / videoSize.width) + lastDraggedProgress
                            
                            progress = max(min(calculatedProgress, 1), 0)
                            isSeeking = true
                            
                            let dragIndex = Int(progress / 0.01)
                            // Checking if FrameThumbnails contains the
                            
                        })
                        .onEnded({ value  in
                            // Storing last known progress
                            lastDraggedProgress = progress
                            // Seeking Video To Dragged Time
                            if let currentPlayerItem = player?.currentItem {
                                let totalDuration = currentPlayerItem.duration.seconds
                                
                                player?.seek(to: .init(seconds: totalDuration * progress, preferredTimescale: 600))
                                
                                // Re - Schedule Timeout Task
                                if isPlaying {
                                    timeoutControls()
                                }
                                
                                // Releasing with slight delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                    isSeeking = false
                                }
                            }
                        })
                )
                .offset(x: progress * videoSize.width > 15 ? -15 : 0)
                .frame(width: 15, height: 15)
        }
        
    }
    
     
    func timeoutControls(){
        ///  controls를 띄운 상태에서 일정 시간이 지나면 controls를 화면에서 제거
        ///  timeoutTask를 이용 이를 구현
        // 이미 timeoutTask가 존재하는 경우, 이를 먼저 취소
        if let timeoutTask {
            timeoutTask.cancel()
        }
        
        // block 안에 timeoutTask를 이용해 하고자 하는 작업 예약
        timeoutTask = .init(block: {
            withAnimation(.easeInOut(duration: 0.35)){
                showPlayerControls = false
            }
        })
        
        // 앞서 예약한 timeoutTask를 mainQueue에 넣어 작업을 실행
        if let timeoutTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: timeoutTask)
        }
    }
    
}

#Preview {
    TempView()
}
