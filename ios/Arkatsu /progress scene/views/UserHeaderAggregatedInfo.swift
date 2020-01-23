//
//  UserHeaderAggregatedInfo.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class UserHeaderAggregatedInfo: UIView {
  let logo: UIImageView
  let info: UILabel
  let status: UILabel

  override init(frame: CGRect) {
    logo = UIImageView(frame: .zero)
    info = UILabel(frame: .zero)
    status = UILabel(frame: .zero)

    super.init(frame: frame)

    addSubview(logo)
    addSubview(info)
    addSubview(status)
  }

  func configure(withModel model: UserAggregatedInfoModel) {

    logo.image = model.logo
    
    info.attributedText = NSAttributedString(
      string: "\(model.name) - \(model.age) lvl",
      attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.infoFontSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )

    status.attributedText = NSAttributedString(
      string: model.status.rawValue,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: Specs.statusFontSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    logo.frame = CGRect(
      x: Specs.commonInsets.left,
      y: Specs.commonInsets.top,
      width: frame.width * Specs.logoSizeRatio,
      height: frame.width * Specs.logoSizeRatio
    )
    logo.layer.cornerRadius = logo.frame.height / 2
    logo.layer.masksToBounds = true

    info.frame = CGRect(
      x: Specs.commonInsets.horizontalSum + logo.frame.width,
      y: Specs.commonInsets.top,
      width: frame.width - logo.frame.width - Specs.commonInsets.left * 3,
      height: logo.frame.height * 0.5
    )

    status.frame = CGRect(
      x: Specs.commonInsets.horizontalSum + logo.frame.width,
      y: Specs.commonInsets.top + info.frame.height / 2,
      width: frame.width - logo.frame.width - Specs.commonInsets.left * 3,
      height: logo.frame.height * 0.5
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private enum Specs {
  static let infoFontSize = CGFloat(22)
  static let statusFontSize = CGFloat(24)
  static let logoSizeRatio = CGFloat(0.4)
  static let commonInsets = UIEdgeInsets(uniform: 8)
}
