//
//  CompanyView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CompanyView: UICollectionViewCell {
  
  let backView: UIView
  let companyName: UILabel
  let logoImageView: UIImageView
  
  var model: CompanyModel!
  // var layout: CompanyViewLayout!
  
  override init(frame: CGRect) {
    self.companyName = UILabel(frame: .zero)
    self.logoImageView = UIImageView(frame: .zero)
    self.backView = UIView(frame: .zero)
    
    companyName.textAlignment = .center
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withModel model: CompanyModel) { // }, layout: CompanyViewLayout) {
     self.model = model
     // self.layout = layout

    if model.activated {
      logoImageView.image = model.companyLogo
    } else {
      logoImageView.image = model.companyLogo.grayscaled
    }

    companyName.attributedText = NSAttributedString(
      string: model.companyName, attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: Specs.nameFontSize),
      ]
    )

     addSubview(backView)
     backView.addSubview(logoImageView)
     backView.addSubview(companyName)
    
     layoutSubviews()
   }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    logoImageView.frame = CGRect(
      x: Specs.cellInsets.left,
      y: Specs.cellInsets.top,
      width: frame.width * Specs.imageRatio - Specs.additionalSpace,
      height: frame.height * Specs.imageRatio - Specs.additionalSpace
    )
    
    companyName.frame = CGRect(
      x: Specs.cellInsets.left,
      y: Specs.cellInsets.bottom * 2 + logoImageView.frame.height,
      width: frame.width * Specs.imageRatio,
      height: frame.height - (Specs.cellInsets.bottom * 2 + logoImageView.frame.height) - Specs.cellInsets.bottom
    )
  }

}

private enum Specs {
  static let additionalSpace = CGFloat(8)
  static let nameFontSize = CGFloat(14)
  static let imageRatio = CGFloat(0.8)
  static let cellInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
}
