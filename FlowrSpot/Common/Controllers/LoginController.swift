//
//  LoginController.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
  let navTitle: Label = {
    let label = Label()
    label.text = "general_app_name".localized()
    label.padding = (15, 0, 15, 0)
    label.font = UIFont.custom(type: .bold, size: 20)
    label.textColor = .flowrPink
    label.textAlignment = .center
    return label
  }()
  
  let usernameField: TextField = {
    let field = TextField()
    field.title = "email_address".localized()
    return field
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubviews(navTitle, usernameField)
    setLayout()
  }
}

// MARK: - Private Methods
private extension LoginController {
  func setLayout() {
    navTitle.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.width.equalTo(view.safeAreaLayoutGuide)
    }
    usernameField.snp.makeConstraints {
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(15)
      $0.top.equalTo(navTitle.snp.bottom).offset(40)
    }
  }
}
