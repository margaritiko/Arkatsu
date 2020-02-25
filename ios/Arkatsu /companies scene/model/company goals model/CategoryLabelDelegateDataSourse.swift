//
//  CategoryLabelDelegateDataSourse.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class CategoryLabelDelegateDataSourse: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  private let categoryReuseIdentifier = "CategoryCell"
  var completion: ((IndexPath) -> Void)? = nil
  var firstUse: Bool = true
  
  var selectedIndex = 0
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    CategoryLabelDelegateDataSourse.fakeCategories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    completion?(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath) as! CategoryView

    cell.configure(
      withModel: CategoryLabelDelegateDataSourse.fakeCategories[indexPath.row]
    )
    cell.layoutSubviews()

    if firstUse, indexPath.row == 0 {
      firstUse = false
      cell.highlight()
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(
      width: UIScreen.main.bounds.width / 3.5,
      height: UIScreen.main.bounds.width / 3.5
    )
  }
  

  static let fakeCategories: [CategoryModel] = [
    CategoryModel(
      categoryName: "Sports", companiesItems: [
        AchievementModel(
          name: "Football",
          logo: UIImage(named: "Football")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Ping-Pong",
          logo: UIImage(named: "ping-pong")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Bowling",
          logo: UIImage(named: "bowling")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Box",
          logo: UIImage(named: "boxer")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Golf",
          logo: UIImage(named: "golf")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Tennis",
          logo: UIImage(named: "tennis")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Basketball",
          logo: UIImage(named: "basketball")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "A. Football",
          logo: UIImage(named: "american-football")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Cheerleader",
          logo: UIImage(named: "cheerleader")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Karate",
          logo: UIImage(named: "karate")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Soccer",
          logo: UIImage(named: "soccer")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Volleyball",
          logo: UIImage(named: "volleyball")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Ice Hockey",
          logo: UIImage(named: "ice-hockey")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Weightlift",
          logo: UIImage(named: "weightlift")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        )
      ]
    ),
    CategoryModel(
      categoryName: "Volunteer", companiesItems: [
        AchievementModel(
          name: "Blood",
          logo: UIImage(named: "blood-transfusion")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Planet",
          logo: UIImage(named: "teamwork (1)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Event",
          logo: UIImage(named: "teamwork")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Disabled",
          logo: UIImage(named: "volunteer (1)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Planting",
          logo: UIImage(named: "volunteer (2)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Cleaning",
          logo: UIImage(named: "volunteer (3)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Garbage",
          logo: UIImage(named: "volunteer (4)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        ),
        AchievementModel(
          name: "Social Help",
          logo: UIImage(named: "volunteer")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1
        )
      ]
    )
  ]

  
}

