//
//  AppDelegate.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.tintColor = UIColor(named: "main")
        
        return true
    }

}
