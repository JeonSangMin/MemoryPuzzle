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
    private var audioPlayer = AVAudioPlayer()
    private var timer = Timer()
    private var isPause = false
    private var time: Double = 0
    
    // 문열리기
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
    
    // 카드 뒤집는 소리
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
    
    // 문 닫히는 소리
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
    
    
    // MARK: TimeManaging
    func startTimer(countDownLabel: UILabel) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        countDownLabel.text = String(format: "%.2f", time)
    }
    
    @objc func update() {
        if(time >= 0.00) {
            time += 0.01
//            countDownLabel.text = String(format: "%.2f", time)
        }
    }
    
    @objc func pause(_ sender: UIButton, countDownLabel: UILabel) {
        if isPause {
            startTimer(countDownLabel: countDownLabel)
//            pauseLabel.isHidden = true
//            view.sendSubviewToBack(pauseLabel)
        } else {
            timer.invalidate()
//            pauseLabel.isHidden = false
//            view.bringSubviewToFront(self.pauseLabel)
        }
        isPause.toggle()
    }
}
