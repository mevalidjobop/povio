//
//  LoginViewController.swift
//  FlowrSpot
//
//  Created by Mirela V on 05/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  private let navTitle = Label()
  private let usernameField = TextField()

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
    setupUsernameField()
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
    view.addSubview(usernameField)
    usernameField.title = "email_address".localized()
    usernameField.snp.makeConstraints {
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(-15)
      $0.top.equalTo(navTitle.snp.bottom).offset(40)
    }
  }
}
