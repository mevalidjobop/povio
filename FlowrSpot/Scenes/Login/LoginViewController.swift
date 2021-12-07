//
//  LoginViewController.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
  func displayHomeRoot()
  func displayError(title: String, message: String)
}

class LoginViewController: UIViewController {
  var interactor: LoginBusinessLogic?
  var router: LoginRoutingLogic?
  
  private let welcomeTitle = Label()
  private let formView = FormView()
  private let usernameField = TextField()
  private let passwordField = TextField()
  private let submitButton = Button()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    self.interactor = interactor
    self.router = router
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
  }
}

// MARK: - Private Methods
private extension LoginViewController {
  func setupViews() {
    setupFormView()
    setupGradient()
    navigationItem.title = "general_app_name".localized()
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
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
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
    usernameField.name = "email"
    usernameField.title = "email_address".localized()
    usernameField.rules = [.required, .email]
    usernameField.delegate = formView
    usernameField.keyboardType = .emailAddress
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

// MARK: - Display Logic
extension LoginViewController: LoginDisplayLogic {
  func displayHomeRoot() {
    submitButton.loading = false
    router?.navigateToHomeRoot()
  }
  func displayError(title: String, message: String) {
    submitButton.loading = false
    router?.navigateToAlert(title: title, message: message, handler: nil)
  }
}

// MARK: - Actions
private extension LoginViewController {
  @objc func submitButtonPressed() {
    view.endEditing(true)
    formView.formValidate()
    guard formView.isValid,
          let payload = formView.values.decode(LoginAPI.LoginPayload.self) else { return }
    submitButton.loading = true
    interactor?.login(payload: payload)
  }
}
