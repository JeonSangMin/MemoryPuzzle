//
//  MainView.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let backgroundImageView = UIImageView()
    private let mainTitle = UILabel()
    private let normalButton = UIButton()
    private let nightMareButton = UIButton()
    private let hellButton = UIButton()
    private let recordButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [backgroundImageView, mainTitle].forEach {
            self.addSubview($0)
        }
        
        let background = UIImage(named: "background")
        backgroundImageView.image = background
        backgroundImageView.contentMode = .scaleToFill
        
        mainTitle.text = "Memory Puzzle"
        mainTitle.font = UIFont(name: "diablo", size: 30)
        mainTitle.textColor = .darkGray
        mainTitle.textAlignment = .center
        
        let buttons = [normalButton, nightMareButton, hellButton, recordButton]
        buttons.forEach {
            self.addSubview($0)
            $0.setBackgroundImage(UIImage(named: "stageBtn.png"), for: .normal)
            $0.imageView?.contentMode = .scaleToFill
            $0.titleLabel?.font = UIFont(name: "diablo", size: 17)
            $0.setTitleColor(.black, for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2.5
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOpacity = 1.0
            $0.layer.shadowOffset = CGSize.zero
            $0.layer.shadowRadius = 8
            $0.layer.masksToBounds = false
            
            $0.snp.makeConstraints {
                $0.centerX.equalTo(self.snp.centerX)
                $0.width.equalTo(self).multipliedBy(0.7)
                $0.height.equalTo(40)
            }
        }
        normalButton.setTitle("Normal", for: .normal)
        nightMareButton.setTitle("NightMare", for: .normal)
        hellButton.setTitle("Hell", for: .normal)
        recordButton.setTitle("Records", for: .normal)
        
        for (index, button) in buttons.enumerated() {
            let top = index == 0 ? mainTitle.snp.bottom : buttons[index - 1].snp.bottom
            
            button.snp.makeConstraints {
                $0.top.equalTo(top).offset(35)
                $0.centerX.equalTo(self.snp.centerX)
                $0.width.equalToSuperview().multipliedBy(0.7)
                $0.height.equalTo(70)
            }
        }
        
    }
    
    private func setContraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
        
        
    }
}
