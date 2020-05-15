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
    private var timer: Timer?
    private var isPause = false
    private var time: Double = 0
    
    // 카드 터치 감지
    func getTouchedCard(cell: PuzzleCell, named: String) {
        if cell.isSelected {
            cell.flipToFront(named: named)
        } else {
            cell.flipToBack(named: named)
        }
    }
    
    func gameSet(pauseButton: UIBarButtonItem, isEnabled: Bool, collectionView: UICollectionView, isUserInteractionEnabled: Bool) {
        pauseButton.isEnabled = isEnabled
        collectionView.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    
    // 문 닫히기
    fileprivate func closeTheGate(leftDoor: UIImageView, rightDoor: UIImageView) {
        leftDoor.isHidden = false
        rightDoor.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            leftDoor.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2, y: 0)
            rightDoor.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width / 2), y: 0)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.closeTheGateAudio()
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
        let label = countDownLabel
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update(_:)), userInfo: label, repeats: true)
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        timer = nil
    }
    
    @objc func update(_ sender: Timer) {
        let label = sender.userInfo as! UILabel
            if(time >= 0) {
                time += 0.1
                label.text = String(format: "%.1f", time)
            }
        }
    
    @objc func pause(_ sender: UIBarButtonItem, countDownLabel: UILabel) {
        if isPause {
            startTimer(countDownLabel: countDownLabel)
        } else {
            stopTimer()
        }
        isPause.toggle()
    }
}
