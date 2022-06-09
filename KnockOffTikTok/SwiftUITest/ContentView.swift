//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Ben on 2021/11/4.
//

import SwiftUI
import AVKit

// 以下是本次案例会用到的一些常量

// 屏幕宽度
let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
// 屏幕高度
let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
// 底部安全区域的高度
let SCREEN_SAFE_BOTTOM: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
// 自定义tabbar 的高度
let TAB_BAR_HEIGHT: CGFloat = 80
// 视频展示区域的高度
let VIDEO_HEIGHT: CGFloat = UIScreen.main.bounds.height - TAB_BAR_HEIGHT - SCREEN_SAFE_BOTTOM


struct Video: Identifiable {
    
    var id: String = UUID().uuidString
    var player: AVPlayer
    var isMoving: Bool = false
    var handle: String
}

struct ContentView: View {
    
    @State var videos: [Video] = [
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v1", ofType: "MP4")!)
                ),
            handle: "handle_1"
        ),
            
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v2", ofType: "MP4")!)
                ),
            handle: "handle_2"
        ),
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v3", ofType: "MP4")!)
                ),
            handle: "handle_3"
        ),
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v4", ofType: "MP4")!)
                ),
            handle: "handle_4"
        ),
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v5", ofType: "MP4")!)
                ),
            handle: "handle_5"
        ),
        Video(
            player:
                AVPlayer(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "v6", ofType: "MP4")!)
                ),
            handle: "handle_6"
        )
    ]
    var body: some View {
        // 本期视频来模仿一下抖音的主界面，通过模仿这个案例，来看一下UIScrollView以及AVPlayer在SwiftUI中的使用
        
        VStack(spacing: 0) {
            
//            PlayerViewController(player: videos.first!.player)
            
            PlayerScrollView(videos: $videos)
                .frame(height: VIDEO_HEIGHT)
            
            // tabbar
            HStack {
                
                Button {
                    
                } label: {
                    Text("首页")
                }
                .frame(maxWidth: .infinity)
                .frame(height: TAB_BAR_HEIGHT)
                
                Button {
                    
                } label: {
                    Text("朋友")
                }
                .frame(maxWidth: .infinity)
                .frame(height: TAB_BAR_HEIGHT)
                
                Button {
                    
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.blue, lineWidth: 2)
                            .offset(x: -2)
                            .frame(width: 30, height: 20)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.red, lineWidth: 2)
                            .offset(x: 2)
                            .frame(width: 30, height: 20)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 12))
                            
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: TAB_BAR_HEIGHT)
                
                
                Button {
                    
                } label: {
                    Text("消息")
                }
                .frame(maxWidth: .infinity)
                .frame(height: TAB_BAR_HEIGHT)
                
                Button {
                    
                } label: {
                    Text("我")
                }
                .frame(maxWidth: .infinity)
                .frame(height: TAB_BAR_HEIGHT)
            }
            .foregroundColor(.white)
            .frame(height: TAB_BAR_HEIGHT + SCREEN_SAFE_BOTTOM, alignment: .top)
            .background(Color.black)
        }
        .background(
            Color.black.ignoresSafeArea()
        )
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
    
}

struct PlayerViewController: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        vc.player = player
        vc.showsPlaybackControls = false
        vc.videoGravity = .resizeAspectFill
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = AVPlayerViewController
    
}

struct PlayerListView: View {
    
    @Binding var videos: [Video]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ForEach(videos) { video in
                
                // 接下来完成点赞、评论、转发等UI布局
                
                ZStack {
                    
                    // 视频播放的view
                    PlayerViewController(player: video.player)
                    
                    HStack(spacing: 30) {
                        
                        
                        // 视频简介，作者id
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Spacer()
                            // SwiftUI中还支持markdown的表达方式，比如加粗
                            Text(" **@等什么君** ")
                                .font(.system(size: 20, weight: .bold))
                            Text("广东人有多令人迷惑 **#广东人美好推荐官** **#搞笑** **#南北差异** **#吹水佬k** **#DOU+小助手** **#抖音小助手**")
                                .font(.system(size: 18))
                        }
                        
                        // 作者头像，点赞数，评论数，转发数
                        VStack {
                            
                            Spacer()
                            
                            ZStack(alignment: .bottom) {
                                Image(video.handle)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 12))
                                    .frame(width: 20, height: 20)
                                    .background(
                                        Circle()
                                            .fill(Color.red)
                                    )
                                    .offset(y: 10)
                            }
                                .padding(.bottom, 30)
                            
                            VStack(spacing: 20) {
                                Button {
                                    
                                } label: {
                                    VStack(spacing: 6) {
                                        Image(systemName: "suit.heart.fill")
                                            .font(.system(size: 28))
                                        Text("29.3w")
                                            .font(.system(size: 18))
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    VStack(spacing: 6) {
                                        Image(systemName: "ellipsis.bubble")
                                            .font(.system(size: 28))
                                        Text("9.3w")
                                            .font(.system(size: 18))
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    VStack(spacing: 6) {
                                        Image(systemName: "arrowshape.turn.up.forward.fill")
                                            .font(.system(size: 28))
                                        Text("2.3w")
                                            .font(.system(size: 18))
                                    }
                                }
                            }
                            .foregroundColor(.white)
                            

                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                }
                
                
                    .frame(height: VIDEO_HEIGHT)
                // 为什么会偏差24，up主也不是很清楚，如果有知道的小伙伴，请视频留言告知，感激不尽。
                    .offset(y: -24)
            }
        }
        .onAppear {
            // 在view显示后，获取第一个video的player
            let player = self.videos[0].player
            // 让player播放video
            player.play()
            // 播放完成后的action设置为none
            player.actionAtItemEnd = .none
            
            // 监听播放到最后的通知
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videos[0].player.currentItem, queue: .main) { _ in
                
                // 重置视频播放时间并再次播放
                player.seek(to: .zero)
                player.play()
            }
        }
    }
}

struct PlayerScrollView: UIViewRepresentable {
    
    @Binding var videos: [Video]
    
    typealias UIViewType = UIScrollView
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        // 隐藏垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = false
        // 垂直方向总是可以拖拽，即使内容不足以撑满view
        scrollView.alwaysBounceVertical = true
        // 打开分页滚动效果
        scrollView.isPagingEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        // 设置scrollView的代理
        scrollView.delegate = context.coordinator
        
        // 计算得到内容的大小
        let contentSize = CGSize(width: SCREEN_WIDTH, height: VIDEO_HEIGHT * CGFloat(videos.count))
        scrollView.contentSize = contentSize
        
        // 获取播放视频的list，通过UIHostingController转换成UIViewController
        let playerListView = UIHostingController(rootView: PlayerListView(videos: $videos))
        playerListView.view.frame = CGRect(origin: .zero, size: contentSize)
        
        // 把播放视频的list添加到scrollView上
        scrollView.addSubview(playerListView.view)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(playerScrollView: self)
    }
    
    // 模仿抖音主界面的案例到此结束，比较简陋，只是使用本地数据大致模拟了一下短视频的滚动切换，还有很多地方没有处理，比如点击视频暂停，音频配乐播放及相关动画效果等等，不过这个案例也大致说明了UIScrollView以及AVPlayer在SwiftUI中的使用，希望能够帮助到需要的人，再见，感谢观看。
    
    // 实现代理
    class Coordinator: NSObject, UIScrollViewDelegate {
        var currIndex: Int = 0
        var playerScrollView: PlayerScrollView
        
        init(playerScrollView: PlayerScrollView) {
            self.playerScrollView = playerScrollView
        }
        
        // 监听滚动停止
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let index = Int(scrollView.contentOffset.y / VIDEO_HEIGHT)
            
            if currIndex != index {
                currIndex = index
                
                for i in 0..<playerScrollView.videos.count {
                    playerScrollView.videos[i].player.seek(to: .zero)
                    playerScrollView.videos[i].player.pause()
                }
                
                playerScrollView.videos[currIndex].player.play()
                // 播放完成后的action设置为none
                playerScrollView.videos[currIndex].player.actionAtItemEnd = .none
                
                // 监听播放到最后的通知
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerScrollView.videos[currIndex].player.currentItem, queue: .main) { _ in
                    
                    // 重置视频播放时间并再次播放
                    self.playerScrollView.videos[self.currIndex].player.seek(to: .zero)
                    self.playerScrollView.videos[self.currIndex].player.play()
                }
            }
        }
    }
    
    
    
    
}
