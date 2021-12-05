//
//  TextField.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class TextField: UIStackView {
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  let textFieldView: UIView = {
    let view = UIView()
    view.backgroundColor = .flowrFieldBackground
    view.borderColor = .flowrFieldBorder
    view.borderWidth = 1
    view.cornerRadius = 3
    return view
  }()
  
  let titleLabel: Label = {
    let label = Label()
    label.font = UIFont.custom(type: .regular, size: 13)
    label.textColor = .flowrFieldTitle
    return label
  }()
  
  let textField: UITextField = {
    let textField = UITextField()
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.returnKeyType = .done
    textField.font = UIFont.custom(type: .regular, size: 13)
    textField.textColor = .flowrFieldText
    return textField
  }()
  
  let errorLabel: Label = {
    let label = Label()
    label.font = UIFont.custom(type: .regular, size: 11)
    label.textColor = .red
    label.text = "Some error"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    axis = .vertical
    spacing = 2
    textField.delegate = self
    textFieldView.addSubviews(titleLabel, textField)
    addArrangedSubviews(textFieldView, errorLabel)
    textFieldView.bringSubviewToFront(textField)
    setLayout()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Private Methods
private extension TextField {
  func setLayout() {
    textFieldView.snp.makeConstraints {
      $0.height.equalTo(48)
    }
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview()
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview()
    }
    textField.snp.makeConstraints {
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview().offset(-15)
      $0.bottom.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.7)
    }
  }
  
  func setPlaceholderFocus() {
    guard (textField.text ?? "").isEmpty else { return }
    let constraints = titleLabel.findConstraints(.height, .top)
    textFieldView.removeConstraints(constraints)
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview().multipliedBy(0.4)
      $0.top.equalToSuperview().offset(5)
    }
    let transform = titleLabel.transform.scaledBy(x: 1, y: 0.8)
    animatePlaceholder(with: transform)
  }
  
  func setPlaceholderBlur() {
    guard (textField.text ?? "").isEmpty else { return }
    let constraints = titleLabel.findConstraints(.height, .top)
    textFieldView.removeConstraints(constraints)
    titleLabel.snp.makeConstraints {
      $0.height.equalToSuperview()
      $0.top.equalToSuperview()
    }
    animatePlaceholder(with: .identity)
  }
  
  func animatePlaceholder(with transform: CGAffineTransform) {
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
      self.titleLabel.transform = transform
      self.layoutIfNeeded()
    }, completion: nil)
  }
}

extension TextField: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    setPlaceholderFocus()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    setPlaceholderBlur()
  }
}
