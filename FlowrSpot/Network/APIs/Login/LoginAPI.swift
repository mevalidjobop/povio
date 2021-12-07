//
//  LoginAPI.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

class LoginAPI {
  private let client: AlamofireNetworkClient
  
  init(client: AlamofireNetworkClient = .default) {
    self.client = client
  }
  
  func login(payload: LoginPayload) -> Promise<LoginResponse> {
    client
      .request(method: .post, endpoint: Endpoints.login, encode: payload)
      .validate()
      .decode(LoginResponse.self)
  }
}
