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
    
    // 상태바 색상 설정
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.isHidden = true
        mainView.delegate = self
        view.addSubview(logoAnimationView)
        view.addSubview(mainView)
        logoAnimationView.pinEdgesToSuperView()
        mainView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    // 네비게이션바 설정
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "diablo", size: 20) as Any], for: .normal)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4784313725, green: 0.02745098039, blue: 0.06274509804, alpha: 1)
    }
    
}

extension MainViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        mainView.isHidden = false
    }
}


extension MainViewController: ButtonIsClicked {
    func pushViewController(cards: [Card], itemsInline: CGFloat, linesOnScreen: CGFloat, ingameViewImageName: String) {
        let stageVC = IngameViewController(cards: cards, itemsInline: itemsInline, linesOnScreen: linesOnScreen, ingameViewImageName: ingameViewImageName)
        self.navigationController?.pushViewController(stageVC, animated: true)
        
    }
}
