//
//  ArkatsuInfoViewController.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ArkatsuInfoViewController: UIViewController {

  struct DataSource {
    let numberOfBonuses: Int
    let bonuses: [DailyBonusModel]
  }

  let loadingIndicator = UIActivityIndicatorView(frame: .zero)
  let animatedArkatsu: UIImageView
  let activityView: ActivityView
  let collectionView: UICollectionView
  let dailyBonusLabel: UILabel
  let scrollView = UIScrollView(frame: .zero)
  let networkService = NetworkService(requestSender: RequestSender())
  var source: DataSource = DataSource(numberOfBonuses: 0, bonuses: [])

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

    scrollView.frame = view.frame
    scrollView.isScrollEnabled = true
    scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.00005)

    scrollView.addSubview(animatedArkatsu)
    scrollView.addSubview(activityView)
    scrollView.addSubview(dailyBonusLabel)
    scrollView.addSubview(collectionView)
    view.addSubview(scrollView)

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

    loadingIndicator.frame = CGRect(
      x: (collectionView.frame.maxX + collectionView.frame.minX) / 2.0 - Specs.activityIndicatorSize / 2.0,
      y: (collectionView.frame.maxY + collectionView.frame.minY) / 2.0 - Specs.activityIndicatorSize / 2.0,
      width: Specs.activityIndicatorSize,
      height: Specs.activityIndicatorSize
    )
    loadingIndicator.startAnimating()
    view.addSubview(loadingIndicator)

    networkService.loadDailyBonuses() { [weak self] bonuses in

      var models: [DailyBonusModel] = []
      for i in 0..<bonuses.count {
        models.append(
          DailyBonusModel(
            description: bonuses[i].description,
            title: bonuses[i].title,
            category: bonuses[i].title,
            bonusLogo: logos[i % 3]
          )
        )
      }

      self?.source = DataSource(numberOfBonuses: bonuses.count, bonuses: models)

      DispatchQueue.main.async {
        self?.collectionView.reloadData()
        self?.loadingIndicator.stopAnimating()
        self?.loadingIndicator.isHidden = true
      }
    }

    networkService.loadUsers() { [weak self] users in
      for user in users {
        if user.name == UserDefaults.standard.string(forKey: "Pet name") {
          var progresses: [Int] = []
          for categoryBridge in user.categories {
            let progress = categoryBridge.first_cost + categoryBridge.second_cost + categoryBridge.third_cost + categoryBridge.forth_cost

            progresses.append(progress)
          }

          DispatchQueue.main.async {
            self?.activityView.configure(progresses: progresses)
          }

          break
        }
      }
    }
  }
}

extension ArkatsuInfoViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = DailyBonusCollectionViewCell.layoutForModel(
      source.bonuses[indexPath.row],
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
    return source.numberOfBonuses
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyBonusIdentifier, for: indexPath) as! DailyBonusCollectionViewCell

    cell.configure(with: source.bonuses[indexPath.row])

    return cell
  }

}

let dailyBonusIdentifier = "DailyBonusCell"
let dailyBonusLabelContent = "Daily Bonus"

private enum Specs {
  static let activityIndicatorSize = CGFloat(50)
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

private let logos = [
  UIImage(named: "education_icon_3")!,
  UIImage(named: "education_icon_2")!,
  UIImage(named: "education_icon_1")!
]
