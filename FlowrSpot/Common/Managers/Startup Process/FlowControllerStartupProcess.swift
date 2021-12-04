//
//  FlowControllerStartupProcess.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 08/10/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

class FlowControllerStartupProcess: StartupProcess {
  private let completion: (FlowController) -> Void
  
  init(completion: @escaping (FlowController) -> Void) {
    self.completion = completion
  }
  
  func run(completion: @escaping (Bool) -> Void) {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let flowController = FlowController(window: window)
    self.completion(flowController)
    flowController.startAppFlow()
    completion(true)
  }
}
