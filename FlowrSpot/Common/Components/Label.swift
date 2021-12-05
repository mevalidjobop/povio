//
//  Label.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

class Label: UILabel {
  var padding: Padding = (0, 0, 0, 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    textColor = .flowrFieldText
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func textRect(
    forBounds bounds: CGRect,
    limitedToNumberOfLines numberOfLines: Int
  ) -> CGRect {
    // Set label padding
    let rect = setupPadding(forBounds: bounds)
    return rect
  }
}

// MARK: - Private Methods
private extension Label {
  func setupPadding(forBounds bounds: CGRect) -> CGRect {
    let edgeInsets = UIEdgeInsets(
      top: padding.top,
      left: padding.left,
      bottom: padding.bottom,
      right: padding.right
    )
    var rect = super.textRect(forBounds: bounds.inset(by: edgeInsets), limitedToNumberOfLines: numberOfLines)
    rect.size.width += padding.left + padding.right
    rect.size.height += padding.top + padding.bottom
    return rect
  }
}
