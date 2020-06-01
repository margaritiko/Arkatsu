//
//  ProgressSceneViewController.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProgressSceneViewController: UIViewController {

  private var cardViewWidth: CGFloat {
    return view.frame.width - Specs.tableViewInsets.horizontalSum
  }

  let loadingIndicator = UIActivityIndicatorView(frame: .zero)
  let aggregatedInfoView = UserHeaderAggregatedInfo(frame: .zero)
  let tableView = UITableView(frame: .zero)
  let networkService: NetworkServiceProtocol = NetworkService(requestSender: RequestSender())
  var categoriesModels = [CategoryCardModel]()

  init() {
    super.init(nibName: nil, bundle: nil)

    tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(named: "add"),
      selectedImage: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
    )
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(named: "add"),
      selectedImage: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    aggregatedInfoView.frame = CGRect(
      x: Specs.userInfoInsets.left,
      y: Specs.userInfoInsets.top,
      width: UIScreen.main.bounds.width - Specs.userInfoInsets.horizontalSum,
      height: view.frame.height * Specs.userInfoHeightRatio
    )
    view.addSubview(aggregatedInfoView)

    tableView.register(CategoryCardView.self, forCellReuseIdentifier: cardReuseIdentifier)
    tableView.frame = CGRect(
      x: Specs.tableViewInsets.left,
      y: Specs.userInfoInsets.top + Specs.tableViewInsets.top * 4 + aggregatedInfoView.frame.height,
      width: cardViewWidth,
      height: view.frame.height - Specs.tableViewInsets.verticalSum - Specs.tableViewInsets.bottom - aggregatedInfoView.frame.height - Specs.bottomOffset
    )

    loadingIndicator.frame = CGRect(
      x: view.frame.width / 2.0 - Specs.activityIndicatorSize / 2.0,
      y: view.frame.height / 2.0 - Specs.activityIndicatorSize / 2.0,
      width: Specs.activityIndicatorSize,
      height: Specs.activityIndicatorSize
    )
    loadingIndicator.startAnimating()
    view.addSubview(loadingIndicator)

    tableView.backgroundColor = UIColor.clear

    networkService.loadUsers() { [aggregatedInfoView, weak self] users in
      var userModel: UserAggregatedInfoModel = defaultUserInfoModel
      for user in users {
        if user.name == UserDefaults.standard.string(forKey: "Pet name") {
          userModel = UserAggregatedInfoModel(
            logo: UIImage(named: "userLogo")!,
            name: user.name,
            age: user.level,
            status: UserStatus.fromString(user.status)
          )

          self?.categoriesModels = []
          for categoryBridge in user.categories {

            guard let allCategories = self?.categoriesModels else {
                continue
            }

            let categoryImage = categoryImages[allCategories.count % categoryImages.count]
            let categoryColorScheme = colorSchemes[allCategories.count % colorSchemes.count]

            let categoryModel = CategoryCardModel(
              maxValue: 100,
              companiesProgressItems: [
                CompanyProgressInfo(companyName: categoryBridge.first, value: categoryBridge.first_cost),
                CompanyProgressInfo(companyName: categoryBridge.second, value: categoryBridge.second_cost),
                CompanyProgressInfo(companyName: categoryBridge.third, value: categoryBridge.third_cost),
                CompanyProgressInfo(companyName: categoryBridge.forth, value: categoryBridge.forth_cost)
              ],
              shouldShowDetails: false,
              categoryName: categoryBridge.title,
              companyLogo: categoryImage,
              colorScheme: categoryColorScheme
            )

            self?.categoriesModels.append(categoryModel)
          }
        }
      }

      DispatchQueue.main.async {
        aggregatedInfoView.configure(withModel: userModel)
        self?.tableView.reloadData()
        self?.loadingIndicator.stopAnimating()
        self?.loadingIndicator.isHidden = true
      }
    }

    view.addSubview(tableView)

    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false

    tableView.reloadData()
  }
}

extension ProgressSceneViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let layout = CategoryCardViewLayout(
      model: categoriesModels[indexPath.row],
      parentWidth: cardViewWidth
    )
    return layout.intrinsicHeight
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let cell = tableView.cellForRow(at: indexPath) as! CategoryCardView
    categoriesModels[indexPath.row].shouldShowDetails = !categoriesModels[indexPath.row].shouldShowDetails
    cell.handleTap()
    tableView.reloadData()
  }
}

extension ProgressSceneViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    categoriesModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cardReuseIdentifier, for: indexPath) as! CategoryCardView
    cell.selectionStyle = .none
    let layout = CategoryCardViewLayout(
      model: categoriesModels[indexPath.row],
      parentWidth: cardViewWidth
    )
    cell.configure(
      withModel: categoriesModels[indexPath.row],
      layout: layout
    )
    cell.layoutSubviews()
    return cell
  }
}

private let defaultUserInfoModel = UserAggregatedInfoModel(
  logo: UIImage(named: "defaultUserLogo")!,
  name: "--",
  age: 0,
  status: .Default
)


private let categoryImages: [UIImage] = [
  UIImage(named: "books")!,
  UIImage(named: "tennis")!,
  UIImage(named: "confetti-1")!,
  UIImage(named: "ICPC")!
]

private let colorSchemes: [CardColorScheme] = [
  .withVioletComponent,
  .withRedComponent,
  .withGreenComponent,
  .withYellowComponent
]

private let cardReuseIdentifier = "CardCell"

private enum Specs {
  static let activityIndicatorSize = CGFloat(50)
  static let userInfoHeightRatio = CGFloat(0.16)
  static let userInfoInsets = UIEdgeInsets(uniform: 32)
  static let tableViewInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
  static let bottomOffset = CGFloat(86)
}
