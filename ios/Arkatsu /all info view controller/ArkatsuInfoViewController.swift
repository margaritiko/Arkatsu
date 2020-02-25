//
//  ArkatsuInfoViewController.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ArkatsuInfoViewController: UIViewController {

  let animatedArkatsu: UIImageView
  let activityView: ActivityView
  let collectionView: UICollectionView
  let taskLabel: UILabel

  init() {
    taskLabel = UILabel(frame: .zero)
    taskLabel.textAlignment = .center

    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = UIColor.clear

    animatedArkatsu = UIImageView(frame: .zero)
    activityView = ActivityView(frame: .zero)

    super.init(nibName: nil, bundle: nil)

    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
      TaskCell.self,
      forCellWithReuseIdentifier: taskCellIdentifier
    )

    view.addSubview(animatedArkatsu)
    view.addSubview(activityView)
    view.addSubview(taskLabel)
    view.addSubview(collectionView)

    tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(named: "personIcon"),
      selectedImage: UIImage(named: "personIcon")?.withRenderingMode(.alwaysOriginal)
    )
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    activityView.addGestureRecognizer(tap)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    let viewController = ProgressSceneViewController()
    present(viewController, animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let imageSide = view.frame.height * Specs.imageRatioToParent
    animatedArkatsu.frame = CGRect(
      x: (view.frame.width - imageSide) / 2.0,
      y: Specs.imageInsets.top,
      width: imageSide,
      height: imageSide
    )
    animatedArkatsu.layer.cornerRadius = animatedArkatsu.frame.height / 2
    animatedArkatsu.layer.masksToBounds = true

    activityView.frame = CGRect(
      x: (view.frame.width - imageSide) / 2.0,
      y: Specs.imageInsets.top,
      width: imageSide,
      height: imageSide
    )

    taskLabel.frame = CGRect(
      x: Specs.taskLabelInsets.left,
      y: Specs.imageInsets.top + activityView.frame.height + Specs.taskLabelInsets.top,
      width: UIScreen.main.bounds.width - Specs.taskLabelInsets.horizontalSum,
      height: Specs.taskLabelHeight
    )

    taskLabel.attributedText = NSAttributedString(
      string: addTaskLabelContent, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.fontSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )

    let tabBarHeight = AppDelegate.tabBarHeight ?? 0
    collectionView.frame = CGRect(
      x: Specs.collectionViewInsets.left,
      y: taskLabel.frame.maxY,
      width: view.frame.width - Specs.collectionViewInsets.horizontalSum,
      height: view.frame.height - tabBarHeight - taskLabel.frame.maxY - Specs.collectionViewInsets.verticalSum
    )
  }
}

private let fakeModels: [TaskModel] = [
  TaskModel(title: "Football with BSE184", details: "Play football with group", weight: 20, status: .sport),
  TaskModel(title: "Discrete Math HW Do the first discrete math homework due to get high score", details: "Do the first discrete math homework due to get high score Do the first discrete math homework due to get high score", weight: 50, status: .education)
]

extension ArkatsuInfoViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(
      width: 360,
      height: collectionView.frame.height
    )
  }
}

extension ArkatsuInfoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fakeModels.count + 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taskCellIdentifier, for: indexPath) as! TaskCell

    if indexPath.row == 0 {
      cell.configureAsTaskFactory()
    } else {
      cell.configure(with: fakeModels[indexPath.row - 1], delegate: self)
    }

    return cell
  }

}

extension ArkatsuInfoViewController: TaskActionsDelegate {
  func showActions(forModel model: TaskModel) {
    let actionsViewController = TaskActionViewController(model: model)
    present(actionsViewController, animated: true, completion: nil)
  }
}

let taskCellIdentifier = "TaskCell"
let addTaskLabelContent = "Your tasks"

private enum Specs {
  static let cellRatio = CGFloat(0.7)
  static let imageRatioToParent = CGFloat(0.38)
  static let imageInsets = UIEdgeInsets(top: 60, left: 24, bottom: 8, right: 24)
  static let collectionViewInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  static let taskLabelInsets = UIEdgeInsets(uniform: 64)
  static let taskLabelHeight = CGFloat(32)
  static let bonusCardWidth = CGFloat(300)
  static let collectionViewOffset = CGFloat(16)
  static let fontSize = CGFloat(30)
}
