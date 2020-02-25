//
//  CompanyModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class AchievementModel {
    
    let name: String
    let logo: UIImage
    let nextGoal: GoalModel
    let lastAchievements: [GoalModel]
    let discount: Double
  
    init(
        name: String,
        logo: UIImage,
        nextGoal: GoalModel,
        lastAchievements: [GoalModel],
        discount: Double
    ) {
        self.logo = logo
        self.name = name
        self.nextGoal = nextGoal
        self.lastAchievements = lastAchievements
        self.discount = discount
    }
}
