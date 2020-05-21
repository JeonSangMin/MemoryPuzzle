//
//  RecordsView.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/21.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecordsView: UIView {
    private let userDefault = UserDefaults.standard
    
    private let imageView = UIImageView()
    private let recordsView = UIView()
    
    private let normalLabel = UILabel()
    private let nightLabel = UILabel()
    private let hellLabel = UILabel()
    
    private let normal = UILabel()
    private let night = UILabel()
    private let hell = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [imageView, recordsView, normalLabel, nightLabel, hellLabel, normal, night, hell].forEach {
            self.addSubview($0)
        }
        
        imageView.image = UIImage(named: "Records")
        
        recordsView.backgroundColor = .white
        recordsView.alpha = 0.5
        
        [normalLabel, nightLabel, hellLabel, normal, night, hell].forEach {
            $0.font = UIFont(name: "diablo", size: 25)
            $0.textColor = #colorLiteral(red: 0.4784313725, green: 0.02745098039, blue: 0.06274509804, alpha: 1)
        }
        
        normalLabel.text = "normal: "
        nightLabel.text = "night: "
        hellLabel.text = "hell: "
        
        let normalDouble = UserDefaults.standard.object(forKey: "Normal") as? Double ?? 0.0
        let normalRecord = String(format: "%.1f", normalDouble)
        normal.text = normalRecord
        
        let nightDouble = UserDefaults.standard.object(forKey: "Night") as? Double ?? 0.0
        let nightRecord = String(format: "%.1f", nightDouble)
        night.text = nightRecord
        
        let hellDouble = UserDefaults.standard.object(forKey: "Hell") as? Double ?? 0.0
        let hellRecord = String(format: "%.1f", hellDouble)
        hell.text = hellRecord
        
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
        recordsView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(self.snp.width).multipliedBy(0.85)
        }
        
        normalLabel.snp.makeConstraints {
            $0.top.equalTo(recordsView.snp.top).inset(30)
            $0.leading.equalTo(recordsView.snp.leading).inset(30)
        }
        
        nightLabel.snp.makeConstraints {
            $0.centerY.equalTo(recordsView.snp.centerY)
            $0.leading.equalTo(recordsView.snp.leading).offset(30)
        }
        
        hellLabel.snp.makeConstraints {
            $0.bottom.equalTo(recordsView.snp.bottom).inset(30)
            $0.leading.equalTo(recordsView.snp.leading).inset(30)
        }
        
        normal.snp.makeConstraints {
            $0.top.equalTo(normalLabel.snp.top)
            $0.trailing.equalTo(recordsView.snp.trailing).inset(10)
        }
        
        night.snp.makeConstraints {
            $0.top.equalTo(nightLabel.snp.top)
            $0.trailing.equalTo(recordsView.snp.trailing).inset(10)
        }

        hell.snp.makeConstraints {
            $0.top.equalTo(hellLabel.snp.top)
            $0.trailing.equalTo(recordsView.snp.trailing).inset(10)
        }

    }
}
