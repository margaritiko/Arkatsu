//
//  ProgressView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class ProgressView: UIView {

  struct Items {
    let aRatio: CGFloat
    let bRatio: CGFloat
    let cRatio: CGFloat
    let othersRatio: CGFloat

    var allRatio: [CGFloat] {
      return [aRatio, bRatio, cRatio, othersRatio]
    }
  }

  let aView: UIView
  let bView: UIView
  let cView: UIView
  let othersView: UIView
  let backgroundView: UIView

  var model: CardProgress!
  var progressItems: Items!
  var colorScheme: CardColorScheme!

  override init(frame: CGRect) {

    aView = UIView(frame: .zero)
    bView = UIView(frame: .zero)
    cView = UIView(frame: .zero)

    othersView = UIView(frame: .zero)
    backgroundView = UIView(frame: .zero)

    super.init(frame: frame)
  }

  func configure(withModel model: CardProgress, colorScheme: CardColorScheme) {
    self.model = model
    self.colorScheme = colorScheme

    backgroundView.backgroundColor = colorScheme.backgroundColor

    progressItems = ProgressView.makeProgressItems(
      maxValue: model.maxValue,
      companiesInfo: model.companiesProgressItems
    )

    let views = [
      backgroundView,
      othersView,
      cView,
      bView,
      aView,
    ]

    views.forEach {
      addSubview($0)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    let views = [
      aView,
      bView,
      cView,
      othersView,
    ]

    backgroundView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: Specs.itemHeight)
    backgroundView.layer.masksToBounds = true
    backgroundView.layer.cornerRadius = Specs.itemHeight / 2

    let width = bounds.width
    let ratio = progressItems.allRatio

    for i in 0..<views.count {
      let add = i > 0 ? views[i - 1].bounds.width : 0
      views[i].frame = CGRect(x: 0, y: 0, width: add + width * ratio[i], height: Specs.itemHeight)
      views[i].layer.masksToBounds = true
      views[i].layer.cornerRadius = Specs.itemHeight / 2
    }

    UIView.animate(withDuration: Specs.changingColorsDuration) { [unowned self] in
      if self.model.shouldShowDetails && self.model.wasActivated {
        self.aView.backgroundColor = self.colorScheme.aColor
        self.bView.backgroundColor = self.colorScheme.bColor
        self.cView.backgroundColor = self.colorScheme.cColor
        self.othersView.backgroundColor = self.colorScheme.othersColor
      } else {
        views.forEach { $0.backgroundColor = self.colorScheme.overallColor }
      }
    }
  }

  /// MARK: Configuring ProgressView with data from model

  private static func makeProgressItems(maxValue: Int, companiesInfo: [CompanyProgressInfo]) -> ProgressView.Items {

    let companies = companiesInfo.map { $0.value }

    if companies.count == 0 {
      return ProgressView.Items(aRatio: 0, bRatio: 0, cRatio: 0, othersRatio: 0)
    } else if companies.count == 1 {
      return ProgressView.Items(
        aRatio: CGFloat(companies[0]) / CGFloat(maxValue),
        bRatio: 0, cRatio: 0, othersRatio: 0
      )
    } else if companies.count == 2 {
      return ProgressView.Items(
        aRatio: CGFloat(companies[0]) / CGFloat(maxValue),
        bRatio: CGFloat(companies[1]) / CGFloat(maxValue),
        cRatio: 0, othersRatio: 0
      )
    } else if companies.count == 3 {
      return ProgressView.Items(
        aRatio: CGFloat(companies[0]) / CGFloat(maxValue),
        bRatio: CGFloat(companies[1]) / CGFloat(maxValue),
        cRatio: CGFloat(companies[2]) / CGFloat(maxValue),
        othersRatio: 0
      )
    } else {
      var sum = 0
      for i in 3..<companies.count {
        sum += companies[i]
      }
      return ProgressView.Items(
        aRatio: CGFloat(companies[0]) / CGFloat(maxValue),
        bRatio: CGFloat(companies[1]) / CGFloat(maxValue),
        cRatio: CGFloat(companies[2]) / CGFloat(maxValue),
        othersRatio: CGFloat(sum) / CGFloat(maxValue)
      )
    }
  }
}

private enum Specs {
  static let itemHeight = CGFloat(29)
  static let changingColorsDuration = 0.2
}
