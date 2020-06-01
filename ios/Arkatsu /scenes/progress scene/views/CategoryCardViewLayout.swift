//
//  CategoryCardViewLayout.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import CoreGraphics
import UIKit

final class CategoryCardViewLayout {

  let imageViewFrame: CGRect
  let categoryNameFrame: CGRect
  let progressViewFrame: CGRect
  let companiesCollectionViewFrame: CGRect

  let imageViewCornerRadius: CGFloat
  let intrinsicHeight: CGFloat

  var companyItemHeight: CGFloat {
    return Specs.companyItemHeight
  }

  var collectionViewItemInsets: UIEdgeInsets {
    return Specs.collectionViewItemInsets
  }

  var backViewInsets: UIEdgeInsets {
    return Specs.backViewInsets
  }

  init(model: CategoryCardModel, parentWidth: CGFloat) {
    let width = parentWidth - Specs.backViewInsets.horizontalSum
    imageViewCornerRadius = width * Specs.imageSizeRatio / 2.0

    imageViewFrame = CGRect(
      x: Specs.commonInsets.left,
      y: Specs.commonInsets.top,
      width: width * Specs.imageSizeRatio,
      height: width * Specs.imageSizeRatio
    )

    categoryNameFrame = CGRect(
      x: Specs.commonInsets.left + Specs.commonInsets.right + imageViewFrame.width + Specs.labelInsets.left,
      y: Specs.commonInsets.top + Specs.labelInsets.top,
      width: width - Specs.commonInsets.left * 2 - Specs.commonInsets.right - imageViewFrame.width,
      height: Specs.categoryNameRatio * imageViewFrame.height
    )

    progressViewFrame = CGRect(
      x: Specs.commonInsets.left + Specs.commonInsets.right + imageViewFrame.width,
      y: Specs.commonInsets.top * 2 + categoryNameFrame.height,
      width: width - Specs.commonInsets.left * 2 - Specs.commonInsets.right - imageViewFrame.width,
      height: Specs.categoryNameRatio * imageViewFrame.height
    )

    companiesCollectionViewFrame = CGRect(
      x: Specs.commonInsets.left,
      y: imageViewFrame.maxY + Specs.commonInsets.top,
      width: width - Specs.commonInsets.horizontalSum,
      height: Specs.collectionViewHeight
    )

    if model.shouldShowDetails, model.wasActivated, model.companiesProgressItems.count > 0 {
      intrinsicHeight = imageViewFrame.height + Specs.commonInsets.verticalSum + Specs.collectionViewHeight + Specs.commonInsets.bottom + Specs.backViewInsets.verticalSum
    } else {
      intrinsicHeight = imageViewFrame.height + Specs.commonInsets.verticalSum + Specs.commonInsets.bottom + Specs.backViewInsets.verticalSum
    }
  }

}

private enum Specs {
  static let commonInsets = UIEdgeInsets(uniform: 8)
  static let imageSizeRatio = CGFloat(0.3)
  static let labelInsets = UIEdgeInsets(uniform: 4)
  static let categoryNameRatio = CGFloat(0.4)
  static let collectionViewHeight = CGFloat(36)
  static let companyItemHeight = CGFloat(24)
  static let collectionViewItemInsets = UIEdgeInsets(uniform: 6)
  static let backViewInsets = UIEdgeInsets(uniform: 10)
}
