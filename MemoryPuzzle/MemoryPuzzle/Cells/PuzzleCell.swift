//
//  PuzzleCell.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/08.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class PuzzleCell: UICollectionViewCell {
    static let identifier = "PuzzleCell"
    var isTouched: Bool = false {
        didSet {
            if isTouched {
                UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            } else {
                UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        }
    }
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipToFront() {
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func flipToBack() {
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    private func setUI() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(self)
        }
        configure(named: "back")
    }
    
    func configure(named imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
