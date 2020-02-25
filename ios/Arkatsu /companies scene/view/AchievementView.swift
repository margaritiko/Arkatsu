//
//  CompanyView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import CoreGraphics
import UIKit

final class AchievementView: UICollectionViewCell {
  
  let backView: UIView
  let achievementName: UILabel
  let logoImageView: UIImageView
  
  var model: AchievementModel!

  override init(frame: CGRect) {
    self.achievementName = UILabel(frame: .zero)
    self.logoImageView = UIImageView(frame: .zero)
    self.backView = UIView(frame: .zero)
    
    achievementName.textAlignment = .center
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.clear

    let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(labelTap)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func labelTapped(_ sender: UITapGestureRecognizer) {
    CoreDataManager.shared.toggleAchievement(withName: model.name)
    recolor()
  }
  
  func configure(withModel model: AchievementModel) { // }, layout: CompanyViewLayout) {
    self.model = model
    
    logoImageView.image = model.logo
    achievementName.attributedText = NSAttributedString(
      string: model.name, attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: Specs.nameFontSize),
      ]
    )

    addSubview(backView)
    backView.addSubview(logoImageView)
    backView.addSubview(achievementName)
    
    layoutSubviews()

    recolor()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    logoImageView.frame = CGRect(
      x: Specs.cellInsets.left,
      y: Specs.cellInsets.top,
      width: frame.width * Specs.imageRatio,
      height: frame.height * Specs.imageRatio
    )
    
    achievementName.frame = CGRect(
      x: Specs.cellInsets.left,
      y: Specs.cellInsets.bottom * 2 + logoImageView.frame.height,
      width: frame.width * Specs.imageRatio,
      height: frame.height - (Specs.cellInsets.bottom * 2 + logoImageView.frame.height) - Specs.cellInsets.bottom
    )
  }

  private func recolor() {
    if CoreDataManager.shared.isAchievementDone(withName: model.name) {
      logoImageView.image = model.logo
    } else {
      logoImageView.image = model.logo.grayscaled
    }
  }
}

private enum Specs {
  static let nameFontSize = CGFloat(15)
  static let imageRatio = CGFloat(0.8)
  static let cellInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
}
