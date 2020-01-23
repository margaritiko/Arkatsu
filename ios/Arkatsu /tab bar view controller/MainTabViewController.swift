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

    AppDelegate.tabBarHeight = tabBar.frame.height

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

}
