//
//  LoginAPI+Endpoints.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

extension LoginAPI {
  enum Endpoints: EndpointEncodable {
    case login

    var path: Path {
      switch self {
      case .login:
        return "users/login"
      }
    }
  }
}
