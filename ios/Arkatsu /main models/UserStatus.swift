//
//  UserStatus.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

enum UserStatus: String, RawRepresentable {
  case Satisfaction
  case Happiness
  case Default

  static func fromString(_ string: String) -> UserStatus {
    if (string == "Satisfaction") {
      return .Satisfaction
    } else {
      return .Happiness
    }
  }
}
