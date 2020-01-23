//
//  DailyBonusDescriptionView.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class DailyBonusDescriptionView: UIView {

  let companyNameLabel: UILabel
  let descriptionLabel: UILabel
  var model: DailyBonusModel?

  override init(frame: CGRect) {
    companyNameLabel = UILabel(frame: .zero)
    descriptionLabel = UILabel(frame: .zero)

    super.init(frame: frame)

    backgroundColor = Specs.cardBackgroundColor
    companyNameLabel.numberOfLines = 0
    descriptionLabel.numberOfLines = 0

    companyNameLabel.textColor = UIColor.black
    descriptionLabel.textColor = UIColor.black

    addSubview(companyNameLabel)
    addSubview(descriptionLabel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    guard let model = model else { return }

    let layout = DailyBonusDescriptionLayout(model: model, width: frame.width)

    companyNameLabel.frame = layout.titleFrame
    descriptionLabel.frame = layout.descriptionFrame

    layer.masksToBounds = true
    layer.cornerRadius = layout.cardCornerRadius
  }

  func configure(with model: DailyBonusModel) {

    self.model = model

    descriptionLabel.attributedText = NSAttributedString(
      string: model.description, attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: Specs.descriptionSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )

    companyNameLabel.attributedText = NSAttributedString(
      string: model.title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.companyTitleSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )
  }

}

private enum Specs {
  static let cardBackgroundColor = UIColor(rgb: 0xF0F0F8)
  static let descriptionSize = CGFloat(16)
  static let companyTitleSize = CGFloat(20)
}
