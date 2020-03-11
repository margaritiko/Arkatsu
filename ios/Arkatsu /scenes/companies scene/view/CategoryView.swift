//
//  CategoryView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
//  Copyright © 2019 Apple. All rights reserved.
//


import UIKit

final class CategoryView: UICollectionViewCell {
  
  let backView: UIView
  let categoryName: UILabel
  
  var model: CategoryModel!
  // var layout: CompanyViewLayout!
  
  override init(frame: CGRect) {
    self.categoryName = UILabel(frame: .zero)
    self.backView = UIView(frame: .zero)
    
    categoryName.textAlignment = .center
    categoryName.textColor = UIColor.black
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    
      // add spaces
    
    super.init(frame: frame)
    
    addSubview(backView)
    addSubview(categoryName)
    
    backgroundColor = UIColor.clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withModel model: CategoryModel) { // }, layout: CompanyViewLayout) {
     self.model = model
     // self.layout = layout

    categoryName.attributedText = NSAttributedString(
      string: model.categoryName, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.categoryFontSize),
        NSAttributedString.Key.foregroundColor: Specs.unselectedColor,
      ]
    )

    addSubview(backView)
    backView.addSubview(categoryName)
    
    layoutSubviews()
  }

  func makeDefault() {
    categoryName.attributedText = NSAttributedString(
      string: model.categoryName, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.categoryFontSize),
        NSAttributedString.Key.foregroundColor: Specs.unselectedColor,
      ]
    )
  }

  func highlight() {
    categoryName.attributedText = NSAttributedString(
      string: model.categoryName, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.categoryFontSize),
        NSAttributedString.Key.foregroundColor: Specs.selectedColor,
      ]
    )
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    categoryName.frame = CGRect(
      x: Specs.cellInsets.left,
      y: Specs.cellInsets.bottom,
      width: frame.width,
      height: frame.height
    )
  }

}

private enum Specs {
  static let cellInsets = UIEdgeInsets(uniform: 2)
  static let categoryFontSize = CGFloat(24)
  static let selectedColor = UIColor.black
  static let unselectedColor = UIColor.lightGray
}

