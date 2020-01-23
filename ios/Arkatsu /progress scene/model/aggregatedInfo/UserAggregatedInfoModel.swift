//
//  UserAggregatedInfoModel.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

struct UserAggregatedInfoModel {
  let logo: UIImage
  let name: String
  // age == number of days
  let age: Int
  let status: UserStatus
}
