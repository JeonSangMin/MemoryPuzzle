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

protocol ComparingCardsDelegate: class {
    func compare(firstCell: IndexPath, secondCell: IndexPath) -> ()
}

final class GameManager {
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    private var matchedCardsCount = 0
    private var time: Double = 0
    private let ingameView = IngameView()
    var isPause = false
    
    weak var delegate: ComparingCardsDelegate?
    
    func showAnswer(dataCards: [Card]) {
           var line = 1
           var row = 1 {
               didSet {
                   if row == 5 {
                       row = 1
                       line += 1
                   }
               }
           }
           dataCards.forEach {
               print($0.name, "  [\(line)행, \(row)열]")
               row += 1
           }
       }
        
    func gameSet(pauseButton: UIBarButtonItem, isEnabled: Bool, collectionView: UICollectionView, isUserInteractionEnabled: Bool) {
        pauseButton.isEnabled = isEnabled
        collectionView.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    // 문 닫히기
    func closeTheGate(leftDoor: UIImageView, rightDoor: UIImageView) {
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
    func flipCardAudio() {
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
    
    @objc func pause(_ sender: UIBarButtonItem, countDownLabel: UILabel, pauseLabel: UILabel) {
        if isPause {
            startTimer(countDownLabel: countDownLabel)
            pauseLabel.isHidden = true
        } else {
            stopTimer()
            pauseLabel.isHidden = false
        }
        isPause.toggle()
    }
    
    func compare(dataCards: [Card] , indexPaths: [IndexPath], collectionView: UICollectionView, isGameSet: inout Bool) {
        if dataCards[indexPaths[0].item].name == dataCards[indexPaths[1].item].name {
            collectionView.isUserInteractionEnabled = false
            matchedCardsCount += 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                indexPaths.forEach {
                    let cell = collectionView.cellForItem(at: $0) as! PuzzleCell
                    cell.isUserInteractionEnabled = false
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.alpha = 0
                    })
                }
                collectionView.isUserInteractionEnabled = true
            }
            switch dataCards.count {
            case 20:
                if dataCards.count == self.matchedCardsCount {
                    isGameSet = true
                    self.stopTimer()
                }
            case 40:
                if self.matchedCardsCount == 2 {
                    isGameSet = true
                    self.stopTimer()
                }
            case 60:
                if self.matchedCardsCount == 4 {
                    isGameSet = true
                    self.stopTimer()
                }
            
            default:
                break;
            }
//            if dataCards.count == self.matchedCardsCount {
//                isGameSet = true
//                self.stopTimer()
//            }
        } else {
            collectionView.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                indexPaths.forEach {
                    let cell = collectionView.cellForItem(at: $0) as! PuzzleCell
                    collectionView.deselectItem(at: $0, animated: false)
                    cell.configure(named: "back")
                }
                collectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    func record(identifier: String) {
        let currentRecord = time
        let bestRecord: Double
        if let tempRecord = UserDefaults.standard.object(forKey: identifier) as? Double {
            if currentRecord < tempRecord {
                bestRecord = currentRecord
            } else {
                bestRecord = tempRecord
            }
        } else {
            bestRecord = currentRecord
        }
        UserDefaults.standard.set(bestRecord, forKey: identifier)
    }
}

