//
//  AVPlayer+Extensions.swift
//  DragGame
//
//  Created by Chase on 2021/4/10.
//

import Foundation
import UIKit
import AVFoundation
extension AVPlayer{
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic(){
        guard let url = Bundle.main.url(forResource: "bensound-cute", withExtension: "mp3")else{fatalError("Failed to find dound file.")}
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
}
