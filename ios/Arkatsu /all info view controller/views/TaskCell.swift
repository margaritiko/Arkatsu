//
//  TaskCell.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {

  let view = TaskView(frame: .zero)
  let plusButton = UIImageView(frame: .zero)
  var model: TaskModel!
  var delegate: TaskActionsDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()

    addSubview(view)
    addSubview(plusButton)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(view)
    addSubview(plusButton)
    view.layer.cornerRadius = Constants.viewCornerLayer
    view.layer.masksToBounds = true

    let cellTap = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(_:)))
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(cellTap)

    plusButton.image = UIImage(named: "plus")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureAsTaskFactory() {
    view.isHidden = true
    plusButton.isHidden = false
  }

  func configure(with model: TaskModel, delegate: TaskActionsDelegate) {
    view.isHidden = false
    plusButton.isHidden = true
    self.delegate = delegate
    view.configure(withModel: model)
    self.model = model
  }

  @objc func cellTapped(_ sender: UITapGestureRecognizer) {
    delegate?.showActions(forModel: model)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()

    plusButton.frame = CGRect(
      x: Constants.commonInsets.left,
      y: Constants.commonInsets.top,
      width: frame.width - Constants.commonInsets.horizontalSum,
      height: frame.height - Constants.commonInsets.verticalSum
    )

    view.frame = CGRect(
      x: Constants.commonInsets.left,
      y: Constants.commonInsets.top,
      width: frame.width - Constants.commonInsets.left * 2,
      height: frame.height - Constants.commonInsets.top * 2
    )
  }

}

private struct Constants {
  static let commonInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  static let viewCornerLayer = CGFloat(32)
}
