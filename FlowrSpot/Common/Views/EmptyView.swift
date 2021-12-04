//
//  EmptyView.swift
//  FlowrSpot
//
//  Created by TK on 26/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import UIKit

class EmptyView: UIView {
  private let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public Methods
extension EmptyView {
  var textColor: UIColor {
    get { label.textColor }
    set { label.textColor = newValue }
  }
  
  var text: String? {
    get { label.text }
    set { label.text = newValue }
  }
  
  var font: UIFont {
    get {
    label.font }
    set { label.font = newValue }
  }
}

// MARK: - Private methods
private extension EmptyView {
  func setupViews() {
    setupLabel()
  }
  
  func setupLabel() {
    addSubview(label)
    label.textAlignment = .center
    label.textColor = .flowrGray
    label.font = UIFont.custom(type: .italicLight, size: 14)
    label.snp.makeConstraints {
      $0.leading.lessThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-20)
    }
  }
}
