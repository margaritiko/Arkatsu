//
//  TaskView.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TaskView: UIView {

  let title = UILabel(frame: .zero)
  let weight = UILabel(frame: .zero)
  let details = UITextView(frame: .zero)
  let label = UILabel(frame: .zero)
  var model: TaskModel!

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(title)
    addSubview(weight)
    addSubview(details)
    addSubview(label)

    details.isEditable = false
    details.isScrollEnabled = true

    label.textAlignment = .center
    weight.textAlignment = .center
    title.textAlignment = .center

    details.layer.cornerRadius = 16
    details.layer.masksToBounds = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    title.frame = CGRect(
      x: Constants.commonInsets.left,
      y: Constants.commonInsets.top,
      width: frame.width - Constants.commonInsets.left - Constants.commonInsets.right,
      height: Constants.labelsHeight
    )

    let space = frame.width - Constants.commonInsets.left * 3
    weight.frame = CGRect(
      x: Constants.commonInsets.left,
      y: title.frame.maxY + Constants.commonInsets.top / 2.0,
      width: space / 2.0,
      height: Constants.labelsHeight
    )

    label.frame = CGRect(
      x: weight.frame.maxX + Constants.commonInsets.left,
      y: title.frame.maxY + Constants.commonInsets.top / 2.0,
      width: space / 2.0,
      height: Constants.labelsHeight
    )

    let parentHeight = frame.height
    details.frame = CGRect(
      x: Constants.commonInsets.left,
      y: label.frame.maxY + Constants.commonInsets.top / 2.0,
      width: frame.width - Constants.commonInsets.left - Constants.commonInsets.right,
      height: parentHeight - (label.frame.maxY - title.frame.minY) - Constants.commonInsets.verticalSum * 2
    )

    label.layer.cornerRadius = label.frame.height / 2.0
    label.layer.masksToBounds = true

    weight.layer.cornerRadius = weight.frame.height / 2.0
    weight.layer.masksToBounds = true
  }


  func configure(withModel model: TaskModel) {
    self.model = model
    switch model.status {
    case .sport:
      title.textColor = Constants.sportColorScheme.titleTextColor
      weight.backgroundColor = Constants.sportColorScheme.weightBackgroundColor
      weight.textColor = Constants.sportColorScheme.weightTextColor
      backgroundColor = Constants.sportColorScheme.cellBackgroundColor
      label.backgroundColor = Constants.sportColorScheme.labelBackgroundColor
      label.textColor = Constants.sportColorScheme.labelTextColor
    case .volonteer:
      title.textColor = Constants.volonteerColorScheme.titleTextColor
      weight.backgroundColor = Constants.volonteerColorScheme.weightBackgroundColor
      weight.textColor = Constants.volonteerColorScheme.weightTextColor
      backgroundColor = Constants.volonteerColorScheme.cellBackgroundColor
      label.backgroundColor = Constants.volonteerColorScheme.labelBackgroundColor
      label.textColor = Constants.volonteerColorScheme.labelTextColor
    case .education:
      title.textColor = Constants.educationColorScheme.titleTextColor
      weight.backgroundColor = Constants.educationColorScheme.weightBackgroundColor
      weight.textColor = Constants.educationColorScheme.weightTextColor
      backgroundColor = Constants.educationColorScheme.cellBackgroundColor
      label.backgroundColor = Constants.educationColorScheme.labelBackgroundColor
      label.textColor = Constants.educationColorScheme.labelTextColor
    case .party:
      title.textColor = Constants.partyColorScheme.titleTextColor
      weight.backgroundColor = Constants.partyColorScheme.weightBackgroundColor
      weight.textColor = Constants.partyColorScheme.weightTextColor
      backgroundColor = Constants.partyColorScheme.cellBackgroundColor
      label.backgroundColor = Constants.partyColorScheme.labelBackgroundColor
      label.textColor = Constants.partyColorScheme.labelTextColor
    }

    details.textColor = .black

    label.text = model.status.description
    title.attributedText = NSAttributedString(
      string: model.title,
      attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
    )
    details.attributedText = NSAttributedString(
      string: model.details,
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
    )
    weight.text = String(model.weight)
  }

}

private struct Constants {
  static let commonInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
  static let labelsHeight = CGFloat(24)
  static let detailsHeight = CGFloat(44)

  static let sportColorScheme = ColorScheme(
    titleTextColor: UIColor.white,
    weightBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    weightTextColor: UIColor.white,
    cellBackgroundColor: UIColor(red:0.13, green:0.75, blue:0.45, alpha:1.0),
    labelBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    labelTextColor: UIColor(red:0.69, green:0.92, blue:0.80, alpha:1.0)
  )

  static let volonteerColorScheme = ColorScheme(
    titleTextColor: UIColor.white,
    weightBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    weightTextColor: UIColor.white,
    cellBackgroundColor: UIColor(red:0.85, green:0.61, blue:0.96, alpha:1.0),
    labelBackgroundColor: UIColor(red:0.94, green:0.89, blue:1.00, alpha:1.0),
    labelTextColor: UIColor(red:0.24, green:0.13, blue:0.43, alpha:1.0)
  )

  static let educationColorScheme = ColorScheme(
    titleTextColor: UIColor.white,
    weightBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    weightTextColor: UIColor.white,
    cellBackgroundColor: UIColor(red:0.92, green:0.80, blue:0.82, alpha:1.0),
    labelBackgroundColor: UIColor(red:0.00, green:0.28, blue:0.44, alpha:1.0),
    labelTextColor: UIColor(red:0.76, green:0.69, blue:0.72, alpha:1.0)
  )

  static let partyColorScheme = ColorScheme(
    titleTextColor: UIColor.white,
    weightBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    weightTextColor: UIColor.white,
    cellBackgroundColor: UIColor(red:0.92, green:0.80, blue:0.82, alpha:1.0),
    labelBackgroundColor: UIColor(red:0.00, green:0.28, blue:0.44, alpha:1.0),
    labelTextColor: UIColor(red:0.76, green:0.69, blue:0.72, alpha:1.0)
  )

  static let notActiveColorScheme = ColorScheme(
    titleTextColor: UIColor.white,
    weightBackgroundColor: UIColor(red:0.49, green:0.05, blue:0.96, alpha:1.0),
    weightTextColor: UIColor.white,
    cellBackgroundColor: UIColor.lightGray,
    labelBackgroundColor: UIColor.gray,
    labelTextColor: UIColor.white
  )
}

