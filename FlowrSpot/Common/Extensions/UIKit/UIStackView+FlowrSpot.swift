//
//  UIStackView+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ subviews: UIView...) {
    subviews.forEach { addArrangedSubview($0) }
  }
}
