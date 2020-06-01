//
//  NetworkServiceProtocol.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
  func numberOfBonuses() -> Int

  func loadDailyBonuses(completionHandler: @escaping (_ bonuses: DailyBonusParser.Model) -> Void)

  func loadUsers(completionHandler: @escaping (_ users: UserParser.Model) -> Void)

  func loadUser(withName name: String, completionHandler: @escaping (_ user: UserModelBridge?) -> Void)
}
