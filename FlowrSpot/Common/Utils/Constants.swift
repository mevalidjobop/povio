//
//  Environment.swift
//  FlowrSpot
//
//  Created by TK on 22/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

enum Constants {
  /// Environment constants
  enum Environment {
    #if DEBUG
    static let isDebug = true
    #else
    static let isDebug = false
    #endif
    
    static let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    static let isDebugOrTest = isDebug || isTesting
  }
}
