//
//  TabBarController.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Private Methods
private extension TabBarController {
  func setupViews() {
    tabBar.barTintColor = .white
    tabBar.tintColor = .red
    
    UITabBarItem.appearance().setTitleTextAttributes([:], for: .normal)
    
    let homeViewController = HomeViewController(delegate: nil)
    let homeNavigationController = NavigationController(rootViewController: homeViewController)
    let viewControllers = [homeNavigationController, UIViewController(), UIViewController(), UIViewController()]
    setViewControllers(viewControllers, animated: true)
    
    if let items = tabBar.items, items.count == viewControllers.count {
      setupTabBarItem(items[0], using: UIImage(named: "favoritesIcons"), title: nil)
      setupTabBarItem(items[1], using: UIImage(named: "commentIcon"), title: nil)
      setupTabBarItem(items[2], using: UIImage(named: "sightingListIcon"), title: nil)
      setupTabBarItem(items[3], using: UIImage(named: "newSightingIcon"), title: nil)
    }
  }
  
  func setupTabBarItem(_ item: UITabBarItem, using image: UIImage?, title: String?) {
    item.image = image
    item.title = title
    item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
  }
}
