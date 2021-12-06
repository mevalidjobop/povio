//
//  UIView+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

extension UIView {
  var width: CGFloat {
    get {
      let width = self.frame.size.width
      return width
    }
    set { self.frame.size.width = newValue }
  }
  
  var height: CGFloat {
    get {
      let height = self.frame.size.height
      return height
    }
    set { self.frame.size.height = newValue }
  }
  
  var borderWidth: CGFloat {
    get {
      let borderWidth = self.layer.borderWidth
      return borderWidth
    }
    set { self.layer.borderWidth = newValue }
  }
  
  var borderColor: UIColor? {
    get {
      guard let borderColor = self.layer.borderColor else { return nil }
      return UIColor(cgColor: borderColor)
    }
    set {
      self.layer.borderColor = newValue?.cgColor
    }
  }
  
  var cornerRadius: CGFloat {
    get {
      let cornerRadius = self.layer.cornerRadius
      return cornerRadius
    }
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
  func findConstraint(_ attr: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
    if let constraints = superview?.constraints {
      for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: attr) {
        return constraint
      }
    }
    return nil
  }
    
  func findConstraints(_ attrs: NSLayoutConstraint.Attribute...) -> [NSLayoutConstraint] {
    let constraints = attrs.reduce(into: [NSLayoutConstraint]()) { partialResult, attr in
      guard let constraint = findConstraint(attr) else { return }
      partialResult.append(constraint)
    }
    return constraints
  }
}

// MARK: - Private Methods
private extension UIView {
  func itemMatch(
    constraint: NSLayoutConstraint,
    layoutAttribute: NSLayoutConstraint.Attribute
  ) -> Bool {
    let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
    let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
    return firstItemMatch || secondItemMatch
  }
}
