//
//  Host.swift
//  FlowrSpot
//
//  Created by TK on 19/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

enum Host {
  case development
  case production
}

extension Host {
  var baseURL: String {
    switch self {
    case .development:
      return "http://flowrspot-api.herokuapp.com/api"
    case .production:
      return "http://prod-flowrspot-api.herokuapp.com/api"
    }
  }
  
  static var current: Host {
    Constants.Environment.isDebug ? .development : .production
  }
}
