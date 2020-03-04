//
//  CategoryModel.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
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
