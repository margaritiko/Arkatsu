//
//  CompaniesSceneViewController.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 02/02/2020.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CompaniesSceneViewController: UIViewController {

    let helpText: UILabel
    let categoryNameCollectionView: UICollectionView
    let companyListCollectionView: UICollectionView
    let delegateDataSource = CategoryLabelDelegateDataSourse()

    var achievements: [String.SubSequence] = []
    let networkService = NetworkService(requestSender: RequestSender())
  
    private let companyReuseIdentifier = "CompanyCell"
    private let categoryReuseIdentifier = "CategoryCell"

    init() {
      helpText = UILabel(frame: .zero)
      helpText.attributedText = NSAttributedString(
        string: Specs.title, attributes: [
          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Specs.helpFieldFontSize),
          NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
        ]
      )
      
      let companyListViewLayout = UICollectionViewFlowLayout()
      companyListViewLayout.scrollDirection = .vertical
      companyListViewLayout.minimumInteritemSpacing = Specs.spaceBetweenCompaniesLabels
      companyListViewLayout.minimumLineSpacing = Specs.spaceBetweenRowsCategoryLabels
      companyListCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: companyListViewLayout)
      companyListCollectionView.showsVerticalScrollIndicator = false
      
      let categoryNameViewLayout = UICollectionViewFlowLayout()
      categoryNameViewLayout.scrollDirection = .horizontal
      categoryNameViewLayout.minimumInteritemSpacing = Specs.spaceBetweenCategoryLabels
      categoryNameViewLayout.minimumLineSpacing = Specs.spaceBetweenRowsCategoryLabels
      categoryNameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryNameViewLayout)
      super.init(nibName: nil, bundle: nil)
      categoryNameCollectionView.showsHorizontalScrollIndicator = false

      tabBarItem = UITabBarItem(
          title: nil,
          image: UIImage(named: "achievements"),
          selectedImage: UIImage(named: "achievements")?.withRenderingMode(.alwaysOriginal)
      )

      networkService.loadUser(
        withName: UserDefaults.standard.string(forKey: "Pet name")!,
        completionHandler: { [weak self] userData in
          if let user = userData {
            self?.achievements = user.achievments.split(separator: ";")
          }
      })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()

      companyListCollectionView.register(CompanyView.self, forCellWithReuseIdentifier: companyReuseIdentifier)
      view.backgroundColor = UIColor.white
      categoryNameCollectionView.register(CategoryView.self, forCellWithReuseIdentifier: categoryReuseIdentifier)
      view.backgroundColor = UIColor.white
      
      companyListCollectionView.backgroundColor = UIColor.white
      categoryNameCollectionView.backgroundColor = UIColor.white
      
      helpText.textAlignment = .center
      helpText.frame = CGRect(
        x: 16,
        y: 48,
        width: UIScreen.main.bounds.width - Specs.commonInsets.top,
        height: 44
      )

      categoryNameCollectionView.frame = CGRect(
        x: 16,
        y: 48 + helpText.frame.height + 16,
        width: UIScreen.main.bounds.width - Specs.commonInsets.top,
        height: 44
      )

      companyListCollectionView.frame = CGRect(
        x: 16,
        y: 16 + categoryNameCollectionView.frame.maxY,
        width: UIScreen.main.bounds.width - Specs.commonInsets.left,
        height: UIScreen.main.bounds.height - Specs.commonInsets.verticalSum - categoryNameCollectionView.frame.height - (AppDelegate.tabBarHeight ?? 0) * 2
      )

      view.addSubview(helpText)
      view.addSubview(categoryNameCollectionView)
      view.addSubview(companyListCollectionView)

      companyListCollectionView.delegate = self
      companyListCollectionView.dataSource = self
      companyListCollectionView.showsVerticalScrollIndicator = false

      companyListCollectionView.reloadData()
      
      delegateDataSource.completion = { [weak self] indexPath in
        if let visibleCells = self?.categoryNameCollectionView.visibleCells as? [CategoryView] {
          visibleCells.forEach { cell in
            cell.makeDefault()
          }
        }
        if let cell = self?.categoryNameCollectionView.cellForItem(at: indexPath) as? CategoryView {
          cell.highlight()
        }
        self?.companyListCollectionView.reloadData()
      }
      categoryNameCollectionView.delegate = delegateDataSource
      categoryNameCollectionView.dataSource = delegateDataSource
      
      categoryNameCollectionView.showsHorizontalScrollIndicator = false

      categoryNameCollectionView.reloadData()
    }
  }
  
  extension CompaniesSceneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let selectedCategory = delegateDataSource.selectedIndex
      
      return CategoryLabelDelegateDataSourse.staticCategories[selectedCategory].companiesItems.count
    }
    

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: companyReuseIdentifier, for: indexPath) as! CompanyView

    let selectedCategory = delegateDataSource.selectedIndex
    
    cell.configure(
      withModel: CategoryLabelDelegateDataSourse.staticCategories[selectedCategory].companiesItems[indexPath.row]
    )
    cell.layoutSubviews()

    let category = CategoryLabelDelegateDataSourse.staticCategories[selectedCategory]
    for achievement in achievements {
      if achievement.lowercased() == category.companiesItems[indexPath.row].companyName.lowercased() {
        cell.markAsActive()
      }
    }
    
    return cell
  }
}

extension CompaniesSceneViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(
      width: UIScreen.main.bounds.width / 3.5,
      height: UIScreen.main.bounds.width / 3.5
    )
  }
}


private enum Specs {
  static let title = "Events"
  static let helpFieldFontSize = CGFloat(44)
  static let commonInsets = UIEdgeInsets(uniform: 32)
  static let collectionViewHeightRatio = CGFloat(0.84)
  static let collectionViewInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
  static let spaceBetweenCategoryLabels = CGFloat(8)
  static let spaceBetweenRowsCategoryLabels = CGFloat(8)
  static let spaceBetweenCompaniesLabels = CGFloat(8)
  static let spaceBetweenRowsCompaniesLabels = CGFloat(8)
}
