//
//  ActivityView.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

final class ActivityView: UIView {

  let imageView: UIImageView

  override init(frame: CGRect) {
    imageView = UIImageView(frame: frame)
    imageView.layer.cornerRadius = imageView.frame.height / 2.0
    imageView.layer.masksToBounds = true

    imageView.image = UIImage(named: "progress")

    super.init(frame: frame)

    addSubview(imageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    imageView.frame = CGRect(
      x: 0,
      y: 0,
      width: frame.width,
      height: frame.height
    )
  }
}
