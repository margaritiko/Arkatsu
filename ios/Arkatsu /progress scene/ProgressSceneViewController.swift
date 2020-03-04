//
//  ProgressSceneViewController.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProgressSceneViewController: UIViewController {

  private var cardViewWidth: CGFloat {
    return view.frame.width - Specs.tableViewInsets.horizontalSum
  }

  let aggregatedInfoView = UserHeaderAggregatedInfo(frame: .zero)
  let tableView = UITableView(frame: .zero)

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
    tableView.backgroundColor = UIColor.clear

    aggregatedInfoView.configure(withModel: fakeUserInfoModel)

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
      model: fakeModels[indexPath.row],
      parentWidth: cardViewWidth
    )
    return layout.intrinsicHeight
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let cell = tableView.cellForRow(at: indexPath) as! CategoryCardView
    fakeModels[indexPath.row].shouldShowDetails = !fakeModels[indexPath.row].shouldShowDetails
    cell.handleTap()
    tableView.reloadData()
  }
}

extension ProgressSceneViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fakeModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cardReuseIdentifier, for: indexPath) as! CategoryCardView
    cell.selectionStyle = .none
    let layout = CategoryCardViewLayout(
      model: fakeModels[indexPath.row],
      parentWidth: cardViewWidth
    )
    cell.configure(
      withModel: fakeModels[indexPath.row],
      layout: layout
    )
    cell.layoutSubviews()
    return cell
  }
}

private let fakeUserInfoModel = UserAggregatedInfoModel(
  logo: UIImage(named: "userLogo")!,
  name: "Piki",
  age: 20,
  status: .Satisfaction
)

private let fakeModels: [CategoryCardModel] = [

  CategoryCardModel(
    maxValue: 40,
    companiesProgressItems: [
      CompanyProgressInfo(companyName: "Control work in Math", value: 12),
      CompanyProgressInfo(companyName: "Colloquium", value: 14),
      CompanyProgressInfo(companyName: "Computer Science Homework", value: 8),
      CompanyProgressInfo(companyName: "History Homework", value: 1)
    ],
    shouldShowDetails: false,
    categoryName: "Education",
    companyLogo: UIImage(named: "books")!,
    colorScheme: .withGreenComponent
  ),

  CategoryCardModel(
    maxValue: 40,
    companiesProgressItems: [
      CompanyProgressInfo(companyName: "Football", value: 12),
      CompanyProgressInfo(companyName: "Tennis", value: 10),
      CompanyProgressInfo(companyName: "Basketball", value: 8),
      CompanyProgressInfo(companyName: "Ping pong", value: 3),
      CompanyProgressInfo(companyName: "Chess", value: 1)
    ],
    shouldShowDetails: false,
    categoryName: "Sport",
    companyLogo: UIImage(named: "sport")!,
    colorScheme: .withRedComponent
  ),
  
  CategoryCardModel(
    maxValue: 40,
    companiesProgressItems: [],
    shouldShowDetails: false,
    categoryName: "Volonteer",
    companyLogo: UIImage(named: "ICPC")!,
    colorScheme: .`withTurquoiseComponent`
  ),

  CategoryCardModel(
    maxValue: 40,
    companiesProgressItems: [
      CompanyProgressInfo(companyName: "Board games", value: 18),
      CompanyProgressInfo(companyName: "University day", value: 10),
    ],
    shouldShowDetails: false,
    categoryName: "Party",
    companyLogo: UIImage(named: "party")!,
    colorScheme: .withVioletComponent
  ),
]

private let cardReuseIdentifier = "CardCell"

private enum Specs {
  static let userInfoHeightRatio = CGFloat(0.16)
  static let userInfoInsets = UIEdgeInsets(uniform: 32)
  static let tableViewInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
  static let bottomOffset = CGFloat(86)
}
