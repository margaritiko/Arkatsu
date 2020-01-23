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
  let dailyBonusLabel: UILabel

  init() {
    dailyBonusLabel = UILabel(frame: .zero)
    dailyBonusLabel.textAlignment = .center

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
      DailyBonusCollectionViewCell.self,
      forCellWithReuseIdentifier: dailyBonusIdentifier
    )

    view.addSubview(animatedArkatsu)
    view.addSubview(activityView)
    view.addSubview(dailyBonusLabel)
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

    dailyBonusLabel.frame = CGRect(
      x: Specs.dailyBonusLabelInsets.left,
      y: Specs.imageInsets.top + activityView.frame.height + Specs.dailyBonusLabelInsets.top,
      width: UIScreen.main.bounds.width - Specs.dailyBonusLabelInsets.horizontalSum,
      height: Specs.dailyBonusLabelHeight
    )

    dailyBonusLabel.attributedText = NSAttributedString(
      string: dailyBonusLabelContent, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.fontSize),
        NSAttributedString.Key.foregroundColor: UIColor.black,
      ]
    )

    let tabBarHeight = AppDelegate.tabBarHeight ?? 0
    collectionView.frame = CGRect(
      x: Specs.collectionViewInsets.left,
      y: dailyBonusLabel.frame.maxY,
      width: view.frame.width - Specs.collectionViewInsets.horizontalSum,
      height: view.frame.height - tabBarHeight - dailyBonusLabel.frame.maxY - Specs.collectionViewInsets.verticalSum
    )
  }
}

private let fakeModels: [DailyBonusModel] = [
  DailyBonusModel(
    description: "This week will be the final of the ICPC programming competition. Become involved in this event!",
    title: "ICPC",
    category: "Uni",
    bonusLogo: UIImage(named: "ICPC")!
  ),

  DailyBonusModel(
    description: "Jeremy is inviting everyone to play football. We are gathering today at 17:00 at the third field. Jeremy is inviting everyone to play football. We are gathering today at 17:00 at the third field.",
    title: "Football",
    category: "Entertainment",
    bonusLogo: UIImage(named: "Football")!
  ),

  DailyBonusModel(
    description: "Pasha collects a company to play the mafia. We are going to 103 rooms at 10 pm.",
    title: "Board games",
    category: "Board games",
    bonusLogo: UIImage(named: "Board_games")!
  )
]

extension ArkatsuInfoViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = DailyBonusCollectionViewCell.layoutForModel(
      fakeModels[indexPath.row],
      width: collectionView.frame.width,
      height: collectionView.frame.height * 0.95
    )

    return CGSize(
      width: layout.totalWidth,
      height: collectionView.frame.height * 0.95
    )
  }
}

extension ArkatsuInfoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fakeModels.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyBonusIdentifier, for: indexPath) as! DailyBonusCollectionViewCell

    cell.configure(with: fakeModels[indexPath.row])

    return cell
  }

}

let dailyBonusIdentifier = "DailyBonusCell"
let dailyBonusLabelContent = "Daily Bonus"

private enum Specs {
  static let cellRatio = CGFloat(0.7)
  static let imageRatioToParent = CGFloat(0.38)
  static let imageInsets = UIEdgeInsets(top: 60, left: 24, bottom: 8, right: 24)
  static let collectionViewInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  static let dailyBonusLabelInsets = UIEdgeInsets(uniform: 64)
  static let dailyBonusLabelHeight = CGFloat(32)
  static let bonusCardWidth = CGFloat(300)
  static let collectionViewOffset = CGFloat(16)
  static let fontSize = CGFloat(30)
}
