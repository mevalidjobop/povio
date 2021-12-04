//
//  HomeRouter.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
  func navigateToFlowerDetails(flower: Flower)
  func navigateToAlert(title: String, message: String, handler: (() -> Void)?)
}

protocol HomeRouterDelegate: AnyObject { /* not implemented */ }

class HomeRouter {
  weak var viewController: HomeViewController?
  weak var delegate: HomeRouterDelegate?
}

// MARK: - Routing Logic
extension HomeRouter: HomeRoutingLogic {
  func navigateToFlowerDetails(flower: Flower) {
    // TODO: - Implement me
  }
  
  func navigateToAlert(title: String, message: String, handler: (() -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "general_ok".localized(), style: .cancel) { _ in handler?() })
    viewController?.present(alert, animated: true, completion: nil)
  }
}
