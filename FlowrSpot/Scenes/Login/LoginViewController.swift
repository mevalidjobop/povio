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
  private let welcomeTitle = Label()
  private let formView = FormView()
  private let usernameField = TextField()
  private let passwordField = TextField()
  private let submitButton = Button()
  
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
    setupGradient()
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
  
  func setupFormView() {
    setupWelcomeTitle()
    setupUsernameField()
    setupPasswordField()
    setupSubmitButton()
    view.addSubview(formView)
    formView.spacing = 16
    formView.customSpacing = [
      passwordField: 48
    ]
    formView.snp.makeConstraints {
      $0.top.equalTo(navTitle.snp.bottom)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(-15)
    }
  }
  
  func setupWelcomeTitle() {
    formView.addArrangedSubViews(welcomeTitle)
    welcomeTitle.text = "welcome_title".localized()
    welcomeTitle.font = UIFont.custom(type: .semibold, size: 20)
    welcomeTitle.padding = (65, 0, 65, 0)
    welcomeTitle.textAlignment = .center
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
    passwordField.delegate = formView
    formView.addArrangedSubViews(passwordField)
  }
  
  func setupSubmitButton() {
    formView.addArrangedSubViews(submitButton)
    submitButton.text = "submit_title".localized()
    submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
  }
  
  func setupGradient() {
    let colorTop = UIColor.flowrGrayGradient.cgColor
    let colorBottom = UIColor.white.cgColor
                  
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 0.3]
    gradientLayer.frame = self.view.bounds
              
    formView.layer.insertSublayer(gradientLayer, at: 0)
  }
}

// MARK: - Actions
private extension LoginViewController {
  @objc func submitButtonPressed() {
    view.endEditing(true)
    formView.formValidate()
    guard formView.isValid else { return }
    submitButton.loading = true
  }
}
