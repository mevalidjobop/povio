//
//  AppDelegate.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  private(set) var flowController: FlowController?
}

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    guard !Constants.Environment.isTesting else { return true } // skip initialization for unit tests
    
    StartupProcessService()
      .execute(process: LoggerStartupProcess())
      .execute(process: FlowControllerStartupProcess { self.flowController = $0 })
    
    return true
  }
}
