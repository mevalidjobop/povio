//
//  FormView.swift
//  FlowrSpot
//
//  Created by Mirela V on 05/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

protocol FormViewDelegate: AnyObject {
  var values: [String: Any] { get set }
  
  func getFields() -> [FormField]
  func fieldValidate(_ field: FormField?)
}

class FormView: UIView {
  private let contentScrollView = UIScrollView()
  private let contentView = UIStackView()
  
  // Validation
  var rules: [String: [Rule]] = [:]
  var errors: [String: String] = [:]
  var attrLabels: [String: String] = [:]
  let validator = Validator()
  var values: [String: Any] = [:]
  var isValid = false
  
  var spacing: CGFloat = 15 {
    didSet {
      contentView.spacing = spacing
    }
  }
  
  var customSpacing: [UIView: CGFloat] = [:] {
    didSet {
      _ = customSpacing.map {
        contentView.setCustomSpacing($0.value, after: $0.key)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    contentScrollView.contentSize = CGSize(width: frame.width, height: contentView.height)
  }
}

// MARK: - Public Methods
extension FormView {
  func addArrangedSubview(_ view: UIView) {
    view.tag = getFields().count
    setupField(view, at: view.tag)
    contentView.addArrangedSubview(view)
  }
  
  func addArrangedSubViews(_ views: UIView...) {
    _ = views.map { subview in
      addArrangedSubview(subview)
    }
  }
  
  func formValidate() {
    getFields().forEach { fieldValidate($0) }
    let errorMsgs = errors.filter { !$0.value.isEmpty }
    isValid = errorMsgs.isEmpty
  }
}

// MARK: - Private Methods
private extension FormView {
  func setupViews() {
    setupContentScrollView()
  }
  
  func setupContentScrollView() {
    setupContentView()
    addSubview(contentScrollView)
    contentScrollView.showsVerticalScrollIndicator = false
    contentScrollView.layoutMargins = .zero
    contentScrollView.snp.makeConstraints {
      $0.width.equalToSuperview()
      $0.height.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
  
  func setupContentView() {
    contentScrollView.addSubview(contentView)
    contentView.axis = .vertical
    contentView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.width.equalToSuperview()
    }
  }
  
  func setupField(_ view: UIView, at index: Int) {
    guard let field = view as? FormField else { return }
    contentView.addArrangedSubview(view)
    guard let name = field.name else { return }
    attrLabels[name] = field.title ?? name
    guard let fieldRules = field.rules else { return }
    rules[name] = fieldRules
  }
}

extension FormView: FormViewDelegate {
  func getFields() -> [FormField] {
    let formFields = contentView.subviews.reduce(into: [FormField]()) { result, field in
      guard let `field` = field as? FormField else { return }
      result.append(field)
    }
    return formFields
  }
  
  func fieldValidate(_ field: FormField?) {
    guard let `field` = field,
          let name = field.name else { return }
    let msg = validator.validate(name, rules[name] ?? [], attrLabels, values) ?? ""
    errors[name] = msg
    field.error = msg
  }
}
