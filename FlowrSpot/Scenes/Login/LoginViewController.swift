//
//  LoginViewController.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  private let navTitle = Label()
  private let formView = FormView()
  private let usernameField = TextField()
  private let passwordField = TextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
  }
}

// MARK: - Private Methods
private extension LoginViewController {
  func setupViews() {
    setupNavTitle()
    setupFormView()
  }
  
  func setupFormView() {
    setupUsernameField()
    setupPasswordField()
    view.addSubview(formView)
    formView.spacing = 16
    formView.snp.makeConstraints {
      $0.top.equalTo(navTitle.snp.bottom)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(-15)
    }
  }
  
  func setupNavTitle() {
    view.addSubview(navTitle)
    navTitle.text = "general_app_name".localized()
    navTitle.padding = (15, 0, 15, 0)
    navTitle.font = UIFont.custom(type: .bold, size: 20)
    navTitle.textColor = .flowrPink
    navTitle.textAlignment = .center
    navTitle.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.width.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func setupUsernameField() {
    usernameField.name = "username"
    usernameField.title = "email_address".localized()
    usernameField.rules = [.required, .email]
    usernameField.delegate = formView
    formView.addArrangedSubViews(usernameField)
  }
  
  func setupPasswordField() {
    passwordField.name = "password"
    passwordField.title = "password".localized()
    passwordField.rules = [.required, .minSize(8)]
    passwordField.isSecureTextEntry = true
    formView.addArrangedSubViews(passwordField)
  }
}
