//
//  GoalModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
final class GoalModel: IGoalProgress {
    let maxValue: Int
    let currentValue: Int
    let goalName: String
    let goalImage: UIImage
  
  init(
    maxValue: Int,
    currentValue: Int,
    goalName: String,
    goalImage: UIImage
  ) {
    self.currentValue = currentValue
    self.maxValue = maxValue
    self.goalImage = goalImage
    self.goalName = goalName
  }
}

