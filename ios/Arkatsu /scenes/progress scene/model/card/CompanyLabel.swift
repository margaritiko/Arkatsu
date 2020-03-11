//
//  CompanyLabel.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CompanyLabel: UICollectionViewCell {

  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  func configure(with model: CompanyProgressInfo, colorScheme: CompanyProgressColorScheme) {
    label.attributedText = NSAttributedString(
      string: model.companyName, attributes: [
        NSAttributedString.Key.font: CompanyProgressColorScheme.font,
        NSAttributedString.Key.foregroundColor: colorScheme.textColor,
      ]
    )
    label.backgroundColor = colorScheme.backgroundColor
    label.textAlignment = .center

    addSubview(label)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    label.frame = CGRect(
      x: 0,
      y: 0,
      width: frame.width,
      height: frame.height
    )
    
    label.layer.cornerRadius = label.frame.height * 2 / 5
    label.layer.masksToBounds = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
