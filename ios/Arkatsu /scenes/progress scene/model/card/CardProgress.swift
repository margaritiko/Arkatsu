//
//  CardProgress.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

protocol CardProgress {
  var maxValue: Int { get }
  var companiesProgressItems: [CompanyProgressInfo] { get }
  var shouldShowDetails: Bool { get }
}
