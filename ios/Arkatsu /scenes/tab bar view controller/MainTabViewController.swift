//
//  MainTabViewController.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import SceneKit
import ARKit
import UIKit

class MainTabViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    tabBar.backgroundColor = UIColor(rgb: 0xFAFAFA)
    view.backgroundColor = UIColor.white

    UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray

    let allInfoViewController = ArkatsuInfoViewController()
    let companiesViewController = CompaniesSceneViewController()

    if ARWorldTrackingConfiguration.isSupported {
      let arController = UIStoryboard.init(
        name: "Main",
        bundle: nil
      ).instantiateViewController(withIdentifier: "ARController")

      viewControllers = [allInfoViewController, arController, companiesViewController]
    } else {
      viewControllers = [allInfoViewController, companiesViewController]
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let kBarHeight = UIScreen.main.bounds.height * 0.12
    tabBar.frame = CGRect(
      origin: CGPoint(x: 0, y: view.frame.height - kBarHeight),
      size: CGSize(width: tabBar.frame.width, height: kBarHeight)
    )
    AppDelegate.tabBarHeight = tabBar.frame.height
  }
}

