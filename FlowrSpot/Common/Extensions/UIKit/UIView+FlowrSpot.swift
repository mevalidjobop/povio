//
//  UIView+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: UIView...) {
    subviews.forEach { addSubview($0) }
  }
  
  func auto(_ layouts: Autolayout...) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.auto(layouts)
  }
}

// MARK: - Private Methods
private extension UIView {
  func auto(_ layouts: [Autolayout]) {
    guard !layouts.isEmpty else { return }
    var layouts = layouts
    let layout = layouts.removeFirst()
    layout.closure(self)
    self.auto(layouts)
  }
}
