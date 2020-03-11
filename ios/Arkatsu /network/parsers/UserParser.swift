//
//  UserParser.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 11.02.2020.
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
}

class UserParser: IParser {
  typealias Model = [UserModelBridge]
  
  func parse(data: Data) -> [UserModelBridge]? {
    // Converts to JSON

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
          let level = element["level"].int {

          models.append(
            UserModelBridge(achievments: achievments, name: name, status: status, level: level)
          )
        }
      }

      return models
    } catch {
      return []
    }
  }
}
