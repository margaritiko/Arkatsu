//
//  DailyBonusDescriptionLayout.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class DailyBonusDescriptionLayout {

  let descriptionFrame: CGRect
  let titleFrame: CGRect
  let intrinsicSize: CGSize

  var cardCornerRadius: CGFloat {
    return Specs.cardCornerRadius
  }

  var totalWidth: CGFloat

  init(model: DailyBonusModel, width: CGFloat) {

    let labelsWidth = width - Specs.commonInsets.horizontalSum

    titleFrame = CGRect(
      x: Specs.commonInsets.left,
      y: Specs.commonInsets.top,
      width: labelsWidth,
      height: UIFont.boldSystemFont(ofSize: Specs.descriptionSize).sizeOfString(
        string: model.title,
        constrainedToWidth: Double(labelsWidth)
      ).height
    )

    descriptionFrame = CGRect(
      x: Specs.commonInsets.left,
      y: titleFrame.height,
      width: labelsWidth,
      height: UIFont.systemFont(ofSize: Specs.descriptionSize).sizeOfString(
        string: model.description,
        constrainedToWidth: Double(labelsWidth)
      ).height
    )

    intrinsicSize = CGSize(
      width: width,
      height: titleFrame.height + Specs.commonInsets.top * 2 + descriptionFrame.height
    )

    totalWidth = width
  }

}

private enum Specs {
  static let commonInsets = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
  static let cardCornerRadius = CGFloat(8)
  static let descriptionSize = CGFloat(18)
  static let companyTitleSize = CGFloat(16)
}
