//
//  AlamofireNetworkClient+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 20/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Alamofire
import Foundation
import PovioKitNetworking

extension AlamofireNetworkClient {
  static var `default`: AlamofireNetworkClient {
    let session: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 60
      configuration.waitsForConnectivity = true
      return Session(configuration: configuration,
                     eventMonitors: [AlamofireConsoleLogger()])
    }()
    
    return .init(session: session)
  }
}
