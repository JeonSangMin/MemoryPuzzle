//
//  Extensions.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/08.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import UIKit

// MARK: 네비게이션바 때문에 가려져서 preferredStatusBarStyle 안먹히기 때문에 사용
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension UIView {
    func pinEdgesToSuperView() {
        self.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
