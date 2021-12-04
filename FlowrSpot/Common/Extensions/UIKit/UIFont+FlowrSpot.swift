//
//  Font+FlowrSpot.swift
//  FlowrSpot
//
//  Created by TK on 04/11/2017.
//  Copyright © 2017 Povio Labs. All rights reserved.
//

import UIKit

extension UIFont {
  static func custom(type: FontStyle, size: CGFloat) -> UIFont {
    UIFont(name: type.name, size: size) ?? .systemFont(ofSize: size)
  }
}

public enum FontStyle: String {
  case light = "Light"
  case regular = "Regular"
  case semibold = "Medium"
  case bold = "Bold"
  case italicLight = "LightItalic"
  case italic = "Italic"
  case italicSemibold = "MediumItalic"
  case italicBold = "BoldItalic"
}

extension FontStyle {
  static let fontFamilyName = "Ubuntu"
  
  var name: String {
    switch self {
    case .regular:
      return FontStyle.fontFamilyName
    case .light, .semibold, .bold, .italicLight, .italic, .italicSemibold, .italicBold:
      return "\(FontStyle.fontFamilyName)-\(rawValue)"
    }
  }
}
