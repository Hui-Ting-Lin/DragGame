//
//  DragGameApp.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//

import SwiftUI
import AVFoundation

@main
struct DragGameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ViewController()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.volume = 0.3
        AVPlayer.bgQueuePlayer.play()
        
        
        return true
    }
}
