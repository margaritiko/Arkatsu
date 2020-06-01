//
//  CategoryCardModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CategoryCardModel: CardProgress {

  let companyLogo: UIImage
  let maxValue: Int
  let companiesProgressItems: [CompanyProgressInfo]
  var shouldShowDetails: Bool
  let categoryName: String
  let colorScheme: CardColorScheme

  init(
    maxValue: Int,
    companiesProgressItems: [CompanyProgressInfo],
    shouldShowDetails: Bool,
    categoryName: String,
    companyLogo: UIImage,
    colorScheme: CardColorScheme
  ) {

    var currrentValue = 0
    companiesProgressItems.forEach { currrentValue += $0.value }
    assert(currrentValue < maxValue)

    self.maxValue = maxValue
    self.companiesProgressItems = companiesProgressItems.sorted(
      by: { $0.value < $1.value }
    ).reversed()
    self.shouldShowDetails = shouldShowDetails
    self.categoryName = categoryName
    self.companyLogo = companyLogo
    self.colorScheme = colorScheme
    
  }


  var wasActivated: Bool {
    var overallProgress = 0
    for item in companiesProgressItems {
      overallProgress += item.value
    }

    return overallProgress > 0
  }

}
