//
//  AppDelegate.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  static var tabBarHeight: CGFloat?
  static var petName: String {
    // TODO: add UserDefaults for saving pet type
    return "redPanda"
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    window?.rootViewController = MainTabViewController()
    
    window?.makeKeyAndVisible()
    return true
  }
}
