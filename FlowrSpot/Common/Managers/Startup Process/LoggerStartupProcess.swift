//
//  LoggerStartupProcess.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 08/10/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

class LoggerStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    Logger.shared.logLevel = Constants.Environment.isDebug ? .debug : .info
    completion(true)
  }
}
