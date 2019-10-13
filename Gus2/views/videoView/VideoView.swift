//
//  VideoView.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit
import AVKit


/// View that can play mp4 video
/// warrning it contains memory leaks!
/// .
/// Widok który potrafi wyświetlić film mp4
/// uwaga zawiera wycieki pamięci
class VideoView: BasicView {
    
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var x: NSKeyValueObservation?
    
    /// display mp4 moview with name <mp4Name>.mp4
    /// .
    /// wyświetl film o nazwie <mp4Name>.mp4
    func display(mp4Name: String) {
        let url: URL = Bundle.main.url(
            forResource: mp4Name, withExtension: "mp4"
        )!
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        player.isMuted = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loop),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player.currentItem!
        )
        player.play()
        x = player.currentItem?.observe(\ AVPlayerItem.presentationSize, changeHandler: {
            [weak self](_: AVPlayerItem, _) in
            self?.handleStart()
        })
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = layer.bounds
        
        
        layer.addSublayer(playerLayer)
    }
    
    
    @objc private func handleStart() {
        setNeedsLayout()
    }
    
    
    @objc private func loop() {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let playerLayer = playerLayer else { return }
        
        let videoAspect: CGFloat = playerLayer.videoRect.height /
            playerLayer.videoRect.width
        
        guard !videoAspect.isNaN else { return }
        let videoSize: CGSize
        
        if videoAspect * bounds.width > bounds.height {
            videoSize = CGSize(
                width: bounds.width,
                height: bounds.width * videoAspect
            )
        } else {
            videoSize = CGSize(
                width: bounds.height / videoAspect,
                height: bounds.height
            )
        }
        let playerX: CGFloat = (bounds.width - videoSize.width) / CGFloat(2.0)
        let playerY: CGFloat = (bounds.height - videoSize.height) / CGFloat(2.0)
        playerLayer.frame = CGRect(
            x: playerX, y: playerY,
            width: videoSize.width,
            height: videoSize.height
        )
    }
    
    
    
}

