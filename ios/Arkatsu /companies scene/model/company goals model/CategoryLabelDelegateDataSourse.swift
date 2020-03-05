//
//  CategoryLabelDelegateDataSourse.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
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
      width: UIScreen.main.bounds.width / 3,
      height: UIScreen.main.bounds.width / 3
    )
  }
  

  static let fakeCategories: [CategoryModel] = [
    CategoryModel(
      categoryName: "Sports", companiesItems: [
        CompanyModel(
          companyName: "Football",
          companyLogo: UIImage(named: "Football")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
//        CompanyModel(
//          companyName: "Ping-Pong",
//          companyLogo: UIImage(named: "ping-pong")!,
//          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
//          lastAchievements: [],
//          discount: 1,
//          activated: true
//        ),
        CompanyModel(
          companyName: "Bowling",
          companyLogo: UIImage(named: "bowling")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Box",
          companyLogo: UIImage(named: "boxer")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Golf",
          companyLogo: UIImage(named: "golf")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Tennis",
          companyLogo: UIImage(named: "tennis")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Basket",
          companyLogo: UIImage(named: "basketball")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Cheerer",
          companyLogo: UIImage(named: "cheerleader")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Karate",
          companyLogo: UIImage(named: "karate")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Soccer",
          companyLogo: UIImage(named: "soccer")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Volleyball",
          companyLogo: UIImage(named: "volleyball")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Hockey",
          companyLogo: UIImage(named: "ice-hockey")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Weightlift",
          companyLogo: UIImage(named: "weightlift")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        )
      ]
    ),
    CategoryModel(
      categoryName: "Volunteer", companiesItems: [
        CompanyModel(
          companyName: "Blood",
          companyLogo: UIImage(named: "blood-transfusion")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Planet",
          companyLogo: UIImage(named: "teamwork (1)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: true
        ),
        CompanyModel(
          companyName: "Event",
          companyLogo: UIImage(named: "teamwork")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Disabled",
          companyLogo: UIImage(named: "volunteer (1)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Planting",
          companyLogo: UIImage(named: "volunteer (2)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Cleaning",
          companyLogo: UIImage(named: "volunteer (3)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
        CompanyModel(
          companyName: "Garbage",
          companyLogo: UIImage(named: "volunteer (4)")!,
          nextGoal: GoalModel(maxValue: 5, currentValue: 1, goalName: "free burger", goalImage:UIImage(named: "burger")!),
          lastAchievements: [],
          discount: 1,
          activated: false
        ),
      ]
    )
  ]

  
}

