//
//  LoginRouter.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
  func navigateToHomeRoot()
  func navigateToAlert(title: String, message: String, handler: (() -> Void)?)
}

class LoginRouter {
  weak var viewController: LoginViewController?
}

// MARK: - Routing Logic
extension LoginRouter: LoginRoutingLogic {
  func navigateToHomeRoot() {
    viewController?.navigationController?.pushViewController(TabBarController(), animated: true)
  }
  
  func navigateToAlert(title: String, message: String, handler: (() -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "general_ok".localized(), style: .cancel) { _ in handler?() })
    viewController?.present(alert, animated: true, completion: nil)
  }
}
