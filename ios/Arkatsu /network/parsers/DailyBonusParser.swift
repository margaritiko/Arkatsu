//
//  DailyBonus.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

struct DailyBonusModelBridge {
  let description: String
  let title: String
}

class DailyBonusParser: IParser {
  typealias Model = [DailyBonusModelBridge]

  func parse(data: Data) -> [DailyBonusModelBridge]? {
    do {
      // Converts to JSON

      let json = try JSON(data: data)
      guard let elements = json.array else {
        print("[NETWORK] Failed to get data from json.array, its empty")
        return []
      }

      // Creates an empty array for DailyBonusModelBridge objects
      var models: [DailyBonusModelBridge] = []
      for element in elements {
        if let title = element["title"].string, let description = element["description"].string {
          models.append(DailyBonusModelBridge(description: description, title: title))
        }
      }

      if models.count == 0 {
        print("[NETWORK] Data is empty")
      }
      return models
    } catch {
      print("[NETWORK] Failed to get data")
      return []
    }
  }
}

