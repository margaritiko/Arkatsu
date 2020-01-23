//
//  CompanyView.swift
//  Arkatsu
//
//  Created by Polina Tarantsova on 13/10/2019.
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
    
      // add spaces
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withModel model: CompanyModel) { // }, layout: CompanyViewLayout) {
     self.model = model
     // self.layout = layout

    logoImageView.image = model.companyLogo
    companyName.attributedText = NSAttributedString(
      string: model.companyName, attributes: [:
        // add attributes
       ]
     )

     // backView.backgroundColor =

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
      width: frame.width * Specs.imageRatio,
      height: frame.height * Specs.imageRatio
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
  static let imageRatio = CGFloat(0.8)
  static let cellInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
}
