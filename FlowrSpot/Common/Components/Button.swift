//
//  Button.swift
//  FlowrSpot
//
//  Created by Mirela V on 06/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class Button: UIButton {
  private lazy var spinner = UIActivityIndicatorView(style: .medium)
  
  var text: String? {
    didSet {
      setTitle(text ?? "", for: .normal)
    }
  }
  
  var loading: Bool = false {
    didSet {
      guard loading else {
        spinner.stopAnimating()
        titleLabel?.layer.opacity = 1
        return
      }
      titleLabel?.layer.opacity = 0
      spinner.startAnimating()
    }
  }
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    setupGradient()
  }
}

// MARK: - Private Methods
private extension Button {
  func setupViews() {
    setupSpinner()
    setupTitleLabel()
  }
  
  func setupSpinner() {
    guard let `titleLabel` = titleLabel else { return }
    insertSubview(spinner, aboveSubview: titleLabel)
    spinner.color = .white
    spinner.hidesWhenStopped = true
    spinner.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  func setupTitleLabel() {
    titleLabel?.textColor = .white
    titleLabel?.font = UIFont.custom(type: .regular, size: 14)
    titleLabel?.textAlignment = .center
    titleLabel?.numberOfLines = 2
  }
  
  func setupGradient() {
    let colorLeft = UIColor.flowrPinkGradient0.cgColor
    let colorRight = UIColor.flowrPinkGradient1.cgColor

    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorLeft, colorRight]
    gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.frame = bounds

    layer.insertSublayer(gradientLayer, below: titleLabel?.layer)
  }
}
