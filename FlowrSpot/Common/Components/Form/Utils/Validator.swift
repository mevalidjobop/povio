//
//  Validator.swift
//  FlowrSpot
//
//  Created by Mirela V on 05/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

enum Rule: Hashable {
  // The field under validation must be present
  // in the input data but can be empty.
  case required
  
  // The field under validation must be formatted
  // as an e-mail address.
  case email
  
  // Validate that value is at least a given size.
  case minSize(Int)
}

class Validator: NSObject {
  /**
   Validate value by the rules.
   
   - Parameters:
      - attribute: Name of the field under validation
      - rules: Defined array of rules
      - attributeLabels: Form fields labels needed to compose a error message
      - values: Form values
   
   - Returns: Error message if invalid.
   */
  func validate(
    _ attribute: String,
    _ rules: [Rule],
    _ attributeLabels: [String: String],
    _ values: [String: Any]?
  ) -> String? {
    let rules = rules.compactMap {
      $0.check(attribute, attributeLabels, values)
    }
    return rules.first
  }
}

// MARK: - Private Methods
private extension Rule {
  func check(
    _ attribute: String,
    _ attributeLabels: [String: String],
    _ values: [String: Any]?
  ) -> String? {
    let value: Any? = values?[attribute]
    switch self {
    case .required:
      return requiredCheck(value, attribute, attributeLabels, values)
    case .email:
      return emailCheck(value, attribute, attributeLabels, values)
    case .minSize(let size):
      return minSizeCheck(value, size, attribute)
    }
  }
  
  // Extend this based on more data types we will handle
  func isEmptyCheck(_ value: Any?) -> Bool {
    guard let `value` = value else { return true }
    // Extend this based on more data types we will handle
    if value is String {
      return (value as? String ?? "").isEmpty
    }
    if value is [Any] {
      return (value as? [Any] ?? []).isEmpty
    }
    return true
  }
  
  func requiredCheck(
    _ value: Any?,
    _ attribute: String,
    _ attributeLabels: [String: String],
    _ values: [String: Any]?
  ) -> String? {
    guard isEmptyCheck(value) else { return nil }
    let attrLabel = attributeLabels[attribute] ?? ""
    return "required".localized(attrLabel)
  }
  
  func emailCheck(
    _ value: Any?,
    _ attribute: String,
    _ attributeLabels: [String: String],
    _ values: [String: Any]?
  ) -> String? {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value as? String)
    guard isValid else {
      let attrLabel = attributeLabels[attribute] ?? ""
      return "invalid_format".localized(attrLabel)
    }
    return nil
  }
  
  func minSizeCheck(
    _ value: Any?,
    _ size: Int,
    _ attribute: String
  ) -> String? {
    if value is String && ((value as? String)?.count ?? 0) < size {
      return "min_size_string".localized(attribute, size)
    }
    if value is Int && (value as? Int ?? 0) < size {
      return "min_size_int".localized(attribute, size)
    }
    if value is [Any] && ((value as? [Any])?.count ?? 0) < size {
      return "min_size_array".localized(attribute, size)
    }
    return nil
  }
}
