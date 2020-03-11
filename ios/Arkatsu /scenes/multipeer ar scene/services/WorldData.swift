//
//  WorldData.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 18.01.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import MultipeerConnectivity

// TODO: realize WorldData
class WorldData: NSObject, NSCopying, NSSecureCoding {
  func copy(with zone: NSZone? = nil) -> Any {

  }

  static var supportsSecureCoding: Bool

  func encode(with coder: NSCoder) {

  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  let map: ARWorldMap
  let petName: String

  init(map: ARWorldMap, petName: String) {
    self.map = map
    self.petName = petName
  }
}
