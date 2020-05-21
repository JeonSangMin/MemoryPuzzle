//
//  RecordsViewController.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/21.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    private let recordsView = RecordsView()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(recordsView)
        setNaviBar()
        recordsView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNaviBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .black
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        titleLabel.text = "records"
        titleLabel.font = UIFont(name: "diablo", size: 25)
        titleLabel.textColor = #colorLiteral(red: 0.4784313725, green: 0.02745098039, blue: 0.06274509804, alpha: 1)
        titleLabel.frame.size = CGSize(width: 100, height: 40)
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    }

}
