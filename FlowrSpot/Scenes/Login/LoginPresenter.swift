//
//  LoginPresenter.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic {
  func loginResult(_ result: Result<LoginAPI.LoginResponse, Error>)
}

class LoginPresenter {
  weak var viewController: LoginDisplayLogic?
}

// MARK: - Presentation Logic
extension LoginPresenter: LoginPresentationLogic {
  func loginResult(_ result: Result<LoginAPI.LoginResponse, Error>) {
    switch result {
    case .success(_):
      viewController?.displayHomeRoot()
    case .failure(let error):
      viewController?.displayError(
        title: "general_error".localized(),
        message: error.localizedDescription
      )
    }
  }
}
