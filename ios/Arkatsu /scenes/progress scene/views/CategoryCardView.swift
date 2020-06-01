//
//  CategoryCardView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class CategoryCardView: UITableViewCell {

  let backView: UIView

  let logoImageView: UIImageView
  let categoryName: UILabel
  let progressView: ProgressView!
  var companiesCollectionView: UICollectionView

  var model: CategoryCardModel!
  var layout: CategoryCardViewLayout!

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

    backView = UIView(frame: .zero)
    logoImageView = UIImageView(frame: .zero)
    categoryName = UILabel(frame: .zero)

    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.minimumInteritemSpacing = Specs.spaceBetweenCompaniesLabels
    collectionViewLayout.minimumLineSpacing = 0
    companiesCollectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: collectionViewLayout
    )
    companiesCollectionView.showsHorizontalScrollIndicator = false

    progressView = ProgressView(frame: .zero)

    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = UIColor.clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withModel model: CategoryCardModel, layout: CategoryCardViewLayout) {
    self.model = model
    self.layout = layout

    logoImageView.image = model.companyLogo
    categoryName.text = model.categoryName

    progressView.configure(withModel: model, colorScheme: model.colorScheme)

    categoryName.attributedText = NSAttributedString(
      string: model.categoryName, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.fontSize),
        NSAttributedString.Key.foregroundColor: UIColor.white,
      ]
    )

    companiesCollectionView.removeFromSuperview()
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.minimumInteritemSpacing = Specs.spaceBetweenCompaniesLabels
    collectionViewLayout.minimumLineSpacing = 0
    companiesCollectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: collectionViewLayout
    )
    companiesCollectionView.showsHorizontalScrollIndicator = false

    companiesCollectionView.backgroundColor = UIColor.clear
    companiesCollectionView.isHidden = !(model.shouldShowDetails && model.wasActivated)

    backView.backgroundColor = model.colorScheme.cardBackgroundColor

    addSubview(backView)
    backView.addSubview(logoImageView)
    backView.addSubview(categoryName)
    backView.addSubview(progressView)
    backView.addSubview(companiesCollectionView)

    companiesCollectionView.dataSource = self
    companiesCollectionView.delegate = self
    companiesCollectionView.register(
      CompanyLabel.self,
      forCellWithReuseIdentifier: companyLabelIdentifier
    )

    layoutSubviews()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    backView.frame = CGRect(
      x: layout.backViewInsets.left,
      y: layout.backViewInsets.top,
      width: frame.width - layout.backViewInsets.horizontalSum,
      height: frame.height - layout.backViewInsets.verticalSum
    )

    logoImageView.layer.masksToBounds = true
    logoImageView.layer.cornerRadius = layout.imageViewCornerRadius

    logoImageView.frame = layout.imageViewFrame
    categoryName.frame = layout.categoryNameFrame
    progressView.frame = layout.progressViewFrame
    companiesCollectionView.frame = layout.companiesCollectionViewFrame

    progressView.layoutSubviews()

    backView.layer.cornerRadius = Specs.cornerRadius
    backView.layer.masksToBounds = true
  }

  func handleTap() {
    guard model.companiesProgressItems.count > 0, model.wasActivated else {
      return
    }

    layout = CategoryCardViewLayout(model: model, parentWidth: bounds.width)

    UIView.animate(
      withDuration: Specs.frameAnimationDuration,
      animations: { [unowned self] in
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.bounds.width, height: self.layout.intrinsicHeight)
      },
      completion: {  [unowned self] success in
        if success {
          self.companiesCollectionView.isHidden = !(self.model.shouldShowDetails && self.model.wasActivated)
        }
      }
    )

    layoutSubviews()
  }
}

extension CategoryCardView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let companyName = indexPath.row == 3 ? othersCompaniesLabelName : model.companiesProgressItems[indexPath.row].companyName

    let calculatedWidth = CompanyProgressColorScheme.font.widthOfString(
      string: companyName,
      constrainedToWidth: .infinity
    )

    return CGSize(
      width: calculatedWidth + layout.collectionViewItemInsets.horizontalSum,
      height: layout.companyItemHeight
    )
  }
}

extension CategoryCardView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return min(4, model.companiesProgressItems.count)
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellColorScheme = CompanyProgressColorScheme(
      backgroundColor: model.colorScheme.getBackgroundColor(for: indexPath.row),
      textColor: model.colorScheme.getTextColor(for: indexPath.row)
    )
    let cell = companiesCollectionView.dequeueReusableCell(withReuseIdentifier: companyLabelIdentifier, for: indexPath) as! CompanyLabel

    if indexPath.row < 3 {
      cell.configure(
        with: model.companiesProgressItems[indexPath.row],
        colorScheme: cellColorScheme
      )
    } else {
      cell.configure(
        with: CompanyProgressInfo(companyName: othersCompaniesLabelName, value: 0),
        colorScheme: cellColorScheme
      )
    }
    return cell
  }
}

private let companyLabelIdentifier = "CompanyLabel"
private let othersCompaniesLabelName = "Others"

private enum Specs {
  static let cornerRadius = CGFloat(16)
  static let fontSize = CGFloat(22)
  static let frameAnimationDuration = 0.2
  static let spaceBetweenCompaniesLabels = CGFloat(8)
}
