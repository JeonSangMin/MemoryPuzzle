//
//  AppDelegate.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/05.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Thread.sleep(forTimeInterval: 1.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let mainVC = MainViewController()
        navigationController.viewControllers = [mainVC]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

