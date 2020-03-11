//
//  RequestFactory.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct RequestsFactory {

  struct DataFromDJango {

    static func dailyBonusConfig() -> RequestConfig<DailyBonusParser> {
      return RequestConfig(request: Request(url: dailyBonusURL), parser: DailyBonusParser())
    }

    static func userConfig() -> RequestConfig<UserParser> {
      return RequestConfig(request: Request(url: userURL), parser: UserParser())
    }

  }
  
}


private let userURL = URL(string: "http://arkatsu.pythonanywhere.com/students/?format=json")!
private let dailyBonusURL = URL(string: "http://arkatsu.pythonanywhere.com/categories/")!
