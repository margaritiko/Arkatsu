//
//  UserParser.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

struct CategoryBridge {
  let title: String

  let first: String
  let second: String
  let third: String
  let forth: String

  let first_cost: Int
  let second_cost: Int
  let third_cost: Int
  let forth_cost: Int
}

struct UserModelBridge {
  let achievments: String
  let name: String
  let status: String
  let level: Int
  let categories: [CategoryBridge]
}

class UserParser: IParser {
  typealias Model = [UserModelBridge]
  
  func parse(data: Data) -> [UserModelBridge]? {
    do {
      
      // Converts to JSON
      let json = try JSON(data: data)
      guard let elements = json.array else {
        return []
      }

      // Creates an empty array for DailyBonusModelBridge objects
      var models: [UserModelBridge] = []
      for element in elements {
        if let name = element["name"].string,
          let achievments = element["achievments"].string,
          let status = element["status"].string,
          let level = element["level"].int,
          let categories = element["categories"].array {

          var listWithCategories: [CategoryBridge] = []
            for category in categories {
              if let title = category["title"].string,
                let first = category["first"].string,
                let second = category["second"].string,
                let third = category["third"].string,
                let forth = category["forth"].string,
                let first_cost = category["first_cost"].int,
                let second_cost = category["second_cost"].int,
                let third_cost = category["third_cost"].int,
                let forth_cost = category["forth_cost"].int {


                listWithCategories.append(CategoryBridge(
                  title: title,
                  first: first,
                  second: second,
                  third: third,
                  forth: forth,
                  first_cost: first_cost,
                  second_cost: second_cost,
                  third_cost: third_cost,
                  forth_cost: forth_cost
                ))
              }
            }


            models.append(
              UserModelBridge(
                achievments: achievments,
                name: name,
                status: status,
                level: level,
                categories: listWithCategories
              )
            )
        }
      }

      return models
    } catch {
      return []
    }
  }
}
