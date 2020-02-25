//
//  CategoryModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

final class CategoryModel {
    
    let categoryName: String
    let companiesItems: [AchievementModel]
    
    init(
        categoryName: String,
        companiesItems: [AchievementModel]
    ) {
        self.categoryName = categoryName
        self.companiesItems = companiesItems
    }
}
