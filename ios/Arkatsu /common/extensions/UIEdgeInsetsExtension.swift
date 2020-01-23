//
//  UIEdgeInsetsExtension.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

  var horizontalSum: CGFloat {
    return left + right
  }

  var verticalSum: CGFloat {
    return top + bottom
  }

  init(uniform value: CGFloat) {
    self.init(top: value, left: value, bottom: value, right: value)
  }
}
