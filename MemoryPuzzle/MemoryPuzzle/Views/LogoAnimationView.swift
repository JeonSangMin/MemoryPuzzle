//
//  LogoAnimationView.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyGif

class LogoAnimationView: UIView {
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "logo.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .black
        self.addSubview(logoGifImageView)
        
        logoGifImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(190)
            $0.height.equalTo(220)
        }
    }
}

extension UIView {
    func pinEdgesToSuperView() {
        self.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
