//
//  FlowController.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 08/10/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class FlowController {
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
    self.window.makeKeyAndVisible()
  }
}

// MARK: - Public Methods
extension FlowController {
  func startAppFlow() {
    window.rootViewController = TabBarController()
  }
}
