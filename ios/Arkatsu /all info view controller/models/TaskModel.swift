//
//  TaskModel.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct TaskModel: Equatable {

    let title: String
    let details: String
    let weight: Int32
    let status: TaskStatus

    init(title: String, details: String, weight: Int32, status: TaskStatus) {
      var updatedWeight = weight
      if weight < 0 {
        updatedWeight = 0
      } else if weight > 100 {
        updatedWeight = 100
      }

      self.title = title
      self.details = details
      self.weight = updatedWeight
      self.status = status
    }

    func equals(_ model: TaskModel) -> Bool {
        return title == model.title
                && details == model.details
                && weight == model.weight
                && status == model.status;
    }

}

