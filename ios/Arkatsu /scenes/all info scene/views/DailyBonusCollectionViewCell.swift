//
//  DailyBonusCollectionViewCell.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class DailyBonusCollectionViewCell: UICollectionViewCell {

  let textCard = DailyBonusDescriptionView(frame: .zero)
  let imageView = UIImageView(frame: .zero)
  var model: DailyBonusModel?

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(textCard)
    addSubview(imageView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    imageView.frame = CGRect(
      x: Specs.commonInsets.left,
      y: Specs.commonInsets.top,
      width: Specs.logoRatio * frame.height,
      height: Specs.logoRatio * frame.height
    )
    guard let model = model else { return }

    let layout = DailyBonusCollectionViewCell.layoutForModel(model, width: frame.width, height: frame.height)

    textCard.frame = CGRect(
      x: Specs.commonInsets.left * 2 + imageView.frame.width,
      y: Specs.commonInsets.top,
      width: layout.intrinsicSize.width - Specs.commonInsets.right,
      height: layout.intrinsicSize.height
    )
  }

  func configure(with model: DailyBonusModel) {
    self.model = model
    textCard.configure(with: model)
    imageView.image = model.bonusLogo
  }

  static func layoutForModel(_ model: DailyBonusModel, width: CGFloat, height: CGFloat) -> DailyBonusDescriptionLayout {
    var contentWidth = width - Specs.logoRatio * height - Specs.commonInsets.left
    var layout = DailyBonusDescriptionLayout(
      model: model,
      width: contentWidth
    )

    while layout.intrinsicSize.height > height {
      contentWidth = contentWidth * 1.2
      layout = DailyBonusDescriptionLayout(
        model: model,
        width: contentWidth
      )
    }

    layout.totalWidth = contentWidth + Specs.logoRatio * width
    return layout
  }

}

private enum Specs {
  static let logoRatio = CGFloat(0.4)
  static let commonInsets = UIEdgeInsets(uniform: 16)
}
