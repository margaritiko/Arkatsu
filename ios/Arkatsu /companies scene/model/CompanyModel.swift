//
//  CompanyModel.swift
//  Arkatsu
//
//  Created by Polina Tarantsova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CompanyModel {
    
    let companyName: String
    let companyLogo: UIImage
    let nextGoal: GoalModel
    let lastAchievements: [GoalModel]
    let discount: Double
  
    init(
        companyName: String,
        companyLogo: UIImage,
        nextGoal: GoalModel,
        lastAchievements: [GoalModel],
        discount: Double
    ) {
        self.companyLogo = companyLogo
        self.companyName = companyName
        self.nextGoal = nextGoal
        self.lastAchievements = lastAchievements
        self.discount = discount
    }
}
