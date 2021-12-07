//
//  TextField.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class TextField: UIStackView {
  private let textFieldContainer = UIView()
  private let titleLabel = Label()
  private let errorLabel = Label()
  
  weak var delegate: FormViewDelegate?
  let textField = UITextField()
  var name: String?
  var rules: [Rule]?
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var error: String? {
    didSet {
      let isValid = (error ?? "").isEmpty
      errorLabel.alpha = isValid ? 0 : 1
      errorLabel.text = error
    }
  }
  
  var isSecureTextEntry: Bool = false {
    didSet {
      textField.isSecureTextEntry = isSecureTextEntry
    }
  }
  
  var keyboardType: UIKeyboardType = .default {
    didSet {
      textField.keyboardType = keyboardType
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    axis = .vertical
    spacing = 2
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
    setupTextFieldContainer()
    setupErrorLabel()
    textFieldContainer.bringSubviewToFront(textField)
  }
  
  func setupTextFieldContainer() {
    setupTitleLabel()
    setupTextField()
    addArrangedSubview(textFieldContainer)
    textFieldContainer.backgroundColor = .flowrFieldBackground
    textFieldContainer.borderColor = .flowrFieldBorder
    textFieldContainer.borderWidth = 1
    textFieldContainer.cornerRadius = 3
    textFieldContainer.snp.makeConstraints {
      $0.height.equalTo(48)
    }
  }
  
  func setupTitleLabel() {
    textFieldContainer.addSubview(titleLabel)
    titleLabel.font = UIFont.custom(type: .regular, size: 13)
    titleLabel.textColor = .flowrFieldTitle
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview()
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview()
    }
  }
  
  func setupTextField() {
    textFieldContainer.addSubview(textField)
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.returnKeyType = .done
    textField.font = UIFont.custom(type: .regular, size: 13)
    textField.textColor = .flowrFieldText
    textField.delegate = self
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
    errorLabel.alpha = 0
  }
  
  func setupPlaceholderFocus() {
    guard (textField.text ?? "").isEmpty else { return }
    let constraints = titleLabel.findConstraints(.height, .top)
    textFieldContainer.removeConstraints(constraints)
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
    textFieldContainer.removeConstraints(constraints)
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
  
  func getFormTextFields() -> [TextField]? {
    let formTextFields = delegate?.getFields().filter { $0 is TextField } as? [TextField]
    return formTextFields
  }
}

// MARK: - UITextField Delegate
extension TextField: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    setupPlaceholderFocus()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    setupPlaceholderBlur()
    guard let name = self.name else { return }
    delegate?.values[name] = textField.text
    delegate?.fieldValidate(self)
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    let formTextFields = getFormTextFields()
    let isLastInForm = formTextFields?.last?.textField == textField
    textField.returnKeyType = isLastInForm ? .done : .next
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let formTextFields = getFormTextFields()
    textField.resignFirstResponder()
    guard textField.returnKeyType == .next else { return true }
    
    guard let index = formTextFields?.firstIndex(of: self),
          let nextTextField = formTextFields?[index + 1] else { return true }
    nextTextField.textField.becomeFirstResponder()
    return true
  }
}
