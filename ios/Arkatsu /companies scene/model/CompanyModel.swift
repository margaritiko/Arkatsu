//
//  CompanyModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CompanyModel {
    
    let companyName: String
    let companyLogo: UIImage
    let nextGoal: GoalModel
    let lastAchievements: [GoalModel]
    let discount: Double
    let activated: Bool
  
    init(
        companyName: String,
        companyLogo: UIImage,
        nextGoal: GoalModel,
        lastAchievements: [GoalModel],
        discount: Double,
        activated: Bool
    ) {
        self.companyLogo = companyLogo
        self.companyName = companyName
        self.nextGoal = nextGoal
        self.lastAchievements = lastAchievements
        self.discount = discount
        self.activated = activated
    }
}
