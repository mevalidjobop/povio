//
//  LoginInteractor.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
  func login(payload: LoginAPI.LoginPayload)
}

class LoginInteractor {
  var presenter: LoginPresentationLogic?
  private let loginAPI: LoginAPI
  
  init(loginAPI: LoginAPI = .init()) {
    self.loginAPI = loginAPI
  }
}

// MARK: - Business Logic
extension LoginInteractor: LoginBusinessLogic {
  func login(payload: LoginAPI.LoginPayload) {
    loginAPI
      .login(payload: payload)
      .observe { [weak self] in
        self?.presenter?.loginResult($0)
      }
  }
}
