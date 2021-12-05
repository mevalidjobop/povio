//
//  TextField.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class TextField: UIStackView {
  private let textFieldView = UIView()
  private let titleLabel = Label()
  private let textField = UITextField()
  private let errorLabel = Label()
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    axis = .vertical
    spacing = 2
    textField.delegate = self
    setupViews()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Private Methods
private extension TextField {
  func setupViews() {
    setupTextFieldView()
    textFieldView.bringSubviewToFront(textField)
  }
  
  func setupTextFieldView() {
    setupTitleLabel()
    setupTextField()
    addArrangedSubview(textFieldView)
    textFieldView.backgroundColor = .flowrFieldBackground
    textFieldView.borderColor = .flowrFieldBorder
    textFieldView.borderWidth = 1
    textFieldView.cornerRadius = 3
    textFieldView.snp.makeConstraints {
      $0.height.equalTo(48)
    }
  }
  
  func setupTitleLabel() {
    textFieldView.addSubview(titleLabel)
    titleLabel.font = UIFont.custom(type: .regular, size: 13)
    titleLabel.textColor = .flowrFieldTitle
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview()
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview()
    }
  }
  
  func setupTextField() {
    textFieldView.addSubview(textField)
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.returnKeyType = .done
    textField.font = UIFont.custom(type: .regular, size: 13)
    textField.textColor = .flowrFieldText
    textField.snp.makeConstraints {
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(15)
      $0.bottom.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.7)
    }
  }
  
  func setupErrorLabel() {
    addArrangedSubview(errorLabel)
    errorLabel.font = UIFont.custom(type: .regular, size: 11)
    errorLabel.textColor = .red
    errorLabel.text = "Some error"
  }
  
  func setupPlaceholderFocus() {
    guard (textField.text ?? "").isEmpty else { return }
    let constraints = titleLabel.findConstraints(.height, .top)
    textFieldView.removeConstraints(constraints)
    let transform = titleLabel.transform.scaledBy(x: 1, y: 0.8)
    setupFocusLayout()
    animatePlaceholder(with: transform)
  }
  
  func setupFocusLayout() {
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview().multipliedBy(0.4)
      $0.top.equalToSuperview().offset(5)
    }
  }
  
  func setupPlaceholderBlur() {
    guard (textField.text ?? "").isEmpty else { return }
    let constraints = titleLabel.findConstraints(.height, .top)
    textFieldView.removeConstraints(constraints)
    setupBlurLayout()
    animatePlaceholder(with: .identity)
  }
  
  func setupBlurLayout() {
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview()
      $0.top.equalToSuperview()
    }
  }
  
  func animatePlaceholder(with transform: CGAffineTransform) {
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
      self.titleLabel.transform = transform
      self.layoutIfNeeded()
    }, completion: nil)
  }
}

// MARK: - UITextField Delegate
extension TextField: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    setupPlaceholderFocus()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    setupPlaceholderBlur()
  }
}
