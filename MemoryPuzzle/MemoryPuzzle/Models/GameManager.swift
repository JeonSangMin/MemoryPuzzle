//
//  GameManager.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

final class GameManager {
    var audioPlayer = AVAudioPlayer()
    
    fileprivate func openTheGate(leftDoor: UIImageView, rightDoor: UIImageView) {
        UIView.animate(withDuration: 1, animations: {
            leftDoor.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width / 2), y: 0)
            rightDoor.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2, y: 0)
            leftDoor.isHidden = true
            rightDoor.isHidden = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
        }
    }
    
    fileprivate func flipCardAudio() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "flip1") else {
            print(#function, " failed to play")
            return
        }
        do {
            try self.audioPlayer = AVAudioPlayer(data: soundAsset.data)
            audioPlayer.play()
        } catch let error as NSError {
            print("Error : \(error.code), Message : \(error.localizedDescription)")
        }
    }
    
    fileprivate func closeTheGateAudio() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "jailDoor") else {
            print(#function, " failed to play")
            return
        }
        do {
            try self.audioPlayer = AVAudioPlayer(data: soundAsset.data)
            audioPlayer.play()
        } catch let error as NSError {
            print("Error : \(error.code), Message : \(error.localizedDescription)")
        }
    }
}
