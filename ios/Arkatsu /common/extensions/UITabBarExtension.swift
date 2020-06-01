//
//  UITabBarExtension.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UITabBar {
  override open func sizeThatFits(_ size: CGSize) -> CGSize {
    super.sizeThatFits(size)
    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = 200
    return sizeThatFits
  }
}
