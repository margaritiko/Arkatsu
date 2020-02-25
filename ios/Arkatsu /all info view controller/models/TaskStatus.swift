//
//  TaskStatus.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

enum TaskStatus {
  case sport
  case volonteer
  case education
  case party

  var description: String {
    switch self {
    case .sport:
      return "Sport"
    case .volonteer:
      return "Volonteer"
    case .education:
      return "Education"
    case .party:
      return "Party"
    }
  }

  static func get(_ name: String) -> TaskStatus {
    switch name {
    case "Sport":
      return .sport
    case "Volonteer":
      return .volonteer
    case "Education":
      return .education
    case "Party":
      return .party
    default:
      return .education
    }
  }
}

