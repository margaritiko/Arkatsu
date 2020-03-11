//
//  NetworkService.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceProtocol {

  // MARK: Life Cycle
  init(requestSender: IRequestSender) {
    self.requestSender = requestSender
  }

  // MARK: Private fields
  let requestSender: IRequestSender
  private var pageToSearchIn = 1
  private var urls = [Int: URL]()


  // MARK: NetworkServiceProtocol
  func numberOfBonuses() -> Int {
    return urls.count
  }

  func loadDailyBonuses(completionHandler: @escaping ([DailyBonusModelBridge]) -> Void) {
    let config = RequestsFactory.DataFromDJango.dailyBonusConfig()

    requestSender.send(config: config) { result in
      switch result {
      case .success(let data):
        print("[NETWORK] Successfully got daily bonuses")
        completionHandler(data)
      case .error(let description):
        print("[NETWORK] Failed with reason: \(description)")
      }
    }

  }


  func loadUsers(completionHandler: @escaping (_ users: UserParser.Model) -> Void) {
    let config = RequestsFactory.DataFromDJango.userConfig()

    requestSender.send(config: config) { result in
      switch result {
      case .success(let data):
        print("[NETWORK] Successfully got users data")
        completionHandler(data)
      case .error(let description):
        print("[NETWORK] Failed with reason: \(description)")
      }
    }

  }


  func loadUser(withName name: String, completionHandler: @escaping (_ user: UserModelBridge?) -> Void) {
    let config = RequestsFactory.DataFromDJango.userConfig()

    requestSender.send(config: config) { result in
      switch result {
      case .success(let data):
        print("[NETWORK] Successfully got users data")
        
        for user in data {
          if user.name == name {
            completionHandler(user)
            return
          }
        }

        completionHandler(nil)
      case .error(let description):
        print("[NETWORK] Failed with reason: \(description)")
      }
    }

  }
}

