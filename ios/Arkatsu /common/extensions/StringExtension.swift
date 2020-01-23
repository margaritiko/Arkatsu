//
//  StringExtension.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

  func widthOfString(string: String, constrainedToWidth width: Double) -> CGFloat {
    return sizeOfString(string: string, constrainedToWidth: width).width
  }

  func sizeOfString(string: String, constrainedToWidth width: Double) -> CGSize {
    let tmpSize = NSString(string: string).boundingRect(
      with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
      options: NSStringDrawingOptions.usesLineFragmentOrigin,
      attributes: [NSAttributedString.Key.font: self],
      context: nil
    ).size
    return CGSize(width: tmpSize.width, height: tmpSize.height + possibleErrorShift)
  }
}

private let possibleErrorShift = CGFloat(16)
