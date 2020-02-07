//
//  AppDelegate.swift
//  CleanArchitectureDemo
//
//  Created by Gökhan Gültekin on 2020-02-06.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.router.start()
        return true
    }
}

