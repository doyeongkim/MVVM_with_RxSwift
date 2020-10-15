//
//  AppDelegate.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/09/08.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        window.rootViewController = ObservableController()
        window.makeKeyAndVisible()

        return true
    }
}

