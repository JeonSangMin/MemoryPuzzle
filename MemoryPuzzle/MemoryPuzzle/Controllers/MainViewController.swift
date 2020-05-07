//
//  MainViewController.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import SwiftyGif

class MainViewController: UIViewController {
    
    private let logoAnimationView = LogoAnimationView()
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTranstransparently()
        view.addSubview(logoAnimationView)
        view.addSubview(mainView)
        logoAnimationView.pinEdgesToSuperView()
        mainView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        mainView.isHidden = true
    }
    
    // 네비게이션바 투명 설정
    private func setNavigationBarTranstransparently() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MainViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        mainView.isHidden = false
    }
}

// MARK: 네비게이션바 때문에 가려져서 preferredStatusBarStyle 안먹히기 때문에 사용
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

