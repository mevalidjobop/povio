//
//  LoginAPI+Models.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

extension LoginAPI {
  struct LoginResponse: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
      case token = "auth_token"
    }
  }
  
  struct LoginPayload: Codable {
    let email: String
    let password: String
  }
}
