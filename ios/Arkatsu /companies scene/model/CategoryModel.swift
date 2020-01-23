//
//  CategoryModel.swift
//  Arkatsu
//
//  Created by Polina Tarantsova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

final class CategoryModel {
    
    let categoryName: String
    let companiesItems: [CompanyModel]
    
    init(
        categoryName: String,
        companiesItems: [CompanyModel]
    ) {
        self.categoryName = categoryName
        self.companiesItems = companiesItems
    }
}
