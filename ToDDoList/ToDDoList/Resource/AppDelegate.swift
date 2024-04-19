//
//  AppDelegate.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 15.04.2024.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LaunchAnimation()
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        
        return true
    }

    


}

