//
//  TaskActionViewController.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TaskActionViewController: UIViewController {

  let markLabel = UILabel(frame: .zero)
  let deleteLabel = UILabel(frame: .zero)
  let model: TaskModel


  init(model: TaskModel) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }


  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  override func viewDidLoad() {
    super.viewDidLoad()

    let secondMinY = view.center.y - Specs.labelHeight / 2.0
    deleteLabel.frame = CGRect(
      x: Specs.commonInsets.left,
      y: secondMinY,
      width: view.frame.width - Specs.commonInsets.horizontalSum,
      height: Specs.labelHeight
    )

    markLabel.frame = CGRect(
      x: Specs.commonInsets.left,
      y: secondMinY - Specs.labelHeight - Specs.commonInsets.top,
      width: view.frame.width - Specs.commonInsets.horizontalSum,
      height: Specs.labelHeight
    )

    view.backgroundColor = .white

    deleteLabel.backgroundColor = Specs.deleteBackground
    deleteLabel.textColor = Specs.deleteTextColor
    deleteLabel.textAlignment = .center

    markLabel.backgroundColor = Specs.markBackground
    markLabel.textColor = Specs.markTextColor
    markLabel.textAlignment = .center

    deleteLabel.layer.cornerRadius = deleteLabel.frame.height / 2.0
    markLabel.layer.cornerRadius = markLabel.frame.height / 2.0

    deleteLabel.layer.masksToBounds = true
    markLabel.layer.masksToBounds = true

    deleteLabel.text = "Delete task"
    markLabel.text = "Mark task"

    view.addSubview(markLabel)
    view.addSubview(deleteLabel)
  }

}


private enum Specs {
  static let commonInsets = UIEdgeInsets(uniform: 8)
  static let labelHeight = CGFloat(48)

  static let deleteBackground = UIColor.red
  static let deleteTextColor = UIColor.white
  static let markBackground = UIColor.green
  static let markTextColor = UIColor.white

}
