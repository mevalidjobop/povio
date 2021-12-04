//
//  NavigationController.swift
//  FlowrSpot
//
//  Created by TK on 17/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Private methods
private extension NavigationController {
  func setupViews() {
    navigationBar.barTintColor = .white
    navigationBar.titleTextAttributes = [.font: UIFont.custom(type: .bold, size: 17),
                                         .foregroundColor: UIColor.flowrPink]
    navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.tintColor = .white
    navigationBar.layer.masksToBounds = false
    
    let backgroundColor = UIColor.white
    navigationBar.barTintColor = backgroundColor
    navigationBar.backgroundColor = backgroundColor
    navigationBar.isTranslucent = false
    
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = backgroundColor
      navigationBar.standardAppearance = appearance
      navigationBar.scrollEdgeAppearance = appearance
    }
  }
}
