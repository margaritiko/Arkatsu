//
//  ActivityView.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import MKRingProgressView
import UIKit

final class ActivityView: UIView {

  let ring1 = RingProgressView()
  let ring2 = RingProgressView()
  let ring3 = RingProgressView()
  let ring4 = RingProgressView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    ring1.startColor = UIColor(red:0.00, green:0.83, blue:0.85, alpha:1.0)
    ring1.endColor = UIColor(rgb: 0x5849B8) // UIColor(red:0.00, green:0.83, blue:1.00, alpha:1.0)
    ring1.ringWidth = Specs.ringWidth
    ring1.progress = 0

    ring2.startColor = UIColor(red:1.00, green:0.30, blue:0.44, alpha:1.0)
    ring2.endColor = UIColor(red:0.98, green:0.17, blue:0.35, alpha:1.0)
    ring2.ringWidth = Specs.ringWidth
    ring2.progress = 0

    ring3.startColor = UIColor(red:0.46, green:0.93, blue:0.00, alpha:1.0)
    ring3.endColor = UIColor(red:0.22, green:0.82, blue:0.17, alpha:1.0)
    ring3.ringWidth = Specs.ringWidth
    ring3.progress = 0

    ring4.startColor = UIColor(red:0.99, green:0.89, blue:0.02, alpha:1.0)
    ring4.endColor = UIColor(red:0.99, green:0.89, blue:0.02, alpha:1.0)
    ring4.ringWidth = Specs.ringWidth
    ring4.progress = 0

    addSubview(ring1)
    addSubview(ring2)
    addSubview(ring3)
    addSubview(ring4)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(progresses: [Int]) {
    guard progresses.count > 3 else { return }

    ring1.progress = Double(progresses[0]) / 100.0
    ring2.progress = Double(progresses[1]) / 100.0
    ring3.progress = Double(progresses[2]) / 100.0
    ring4.progress = Double(progresses[3]) / 100.0
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    ring1.frame = CGRect(
      x: 0,
      y: 0,
      width: frame.width,
      height: frame.height
    )

    ring2.frame = bounds.insetBy(
      dx: Specs.ringWidth + Specs.ringSpacing,
      dy: Specs.ringWidth + Specs.ringSpacing
    )
    ring3.frame = bounds.insetBy(
      dx: 2 * Specs.ringWidth + 2 * Specs.ringSpacing,
      dy: 2 * Specs.ringWidth + 2 * Specs.ringSpacing
    )
    ring4.frame = bounds.insetBy(
      dx: 3 * Specs.ringWidth + 3 * Specs.ringSpacing,
      dy: 3 * Specs.ringWidth + 3 * Specs.ringSpacing
    )
  }
}

private enum Specs {
  static let ringWidth = CGFloat(25)
  static let ringSpacing = CGFloat(8)
}
