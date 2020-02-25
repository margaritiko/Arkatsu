//
//  UIImageExtension.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  var grayscaled: UIImage? {
    let ciImage = CIImage(image: self)
    let grayscale = ciImage?.applyingFilter("CIColorControls",
                                            parameters: [ kCIInputSaturationKey: 0.0 ])
    if let gray = grayscale{
      return UIImage(ciImage: gray)
    }
    else{
      return nil
    }
  }
}
