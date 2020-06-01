//
//  GeometryExtensions.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit

// MARK: - float4x4 extensions

extension float4x4 {
  var translation: SIMD3<Float> {
    get {
      let translation = columns.3
      return SIMD3<Float>(translation.x, translation.y, translation.z)
    }
    set(newValue) {
      columns.3 = SIMD4<Float>(newValue.x, newValue.y, newValue.z, columns.3.w)
    }
  }

  var orientation: simd_quatf {
    return simd_quaternion(self)
  }

  init(uniformScale scale: Float) {
    self = matrix_identity_float4x4
    columns.0.x = scale
    columns.1.y = scale
    columns.2.z = scale
  }
}

// MARK: - CGPoint extensions

extension CGPoint {
  init(_ vector: SCNVector3) {
    self.init(x: CGFloat(vector.x), y: CGFloat(vector.y))
  }

  var length: CGFloat {
    return sqrt(x * x + y * y)
  }
}
