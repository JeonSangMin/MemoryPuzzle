//
//  IngameView.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/08.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class IngameView: UIView {
    private let imageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(background: String) {
        imageView.image = UIImage(named: background)
    }
    
}
