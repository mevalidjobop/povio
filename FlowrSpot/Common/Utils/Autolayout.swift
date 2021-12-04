//
//  Autolayout.swift
//  FlowrSpot
//
//  Created by Mirela V on 04/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

// Autolayout shortcuts
struct Autolayout {
  var closure: ((UIView) -> Void)
    
  init (_ closure: @escaping ((UIView) -> Void)) {
    self.closure = closure
  }
  
  static func fillX(
    safeArea: Bool = false,
    _ left: CGFloat = 0,
    _ right: CGFloat = 0
  ) -> Autolayout {
    let layout = Autolayout { view in
      let superview = Autolayout.superview(view)
      
      var leadingAnchor = superview.leadingAnchor
      var trailingAnchor = superview.trailingAnchor
      if safeArea {
        leadingAnchor = superview.safeAreaLayoutGuide.leadingAnchor
        trailingAnchor = superview.safeAreaLayoutGuide.trailingAnchor
      }
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left).isActive = true
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -right).isActive = true
    }
    return layout
  }
  
  static func topAnchor(
      ofView: UIView? = nil,
      safeArea: Bool = false,
      _ constant: CGFloat = 0
    ) -> Autolayout {
      let layout = Autolayout { view in
        let relationView = relationView(view, ofView: ofView)
        let topAnchor = safeArea
          ? relationView.safeAreaLayoutGuide.topAnchor
          : relationView.topAnchor
        view.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
      }
      return layout
    }
}

private extension Autolayout {
  static func superview(_ view: UIView) -> UIView {
    guard let superview = view.superview else {
      preconditionFailure("Autolayout: Missing superview!")
    }
    return superview
  }
  
  static func relationView(_ view: UIView, ofView: UIView?) -> UIView {
    guard let relationView = ofView ?? view.superview else {
      preconditionFailure("Autolayout: Missing relation view!")
    }
    return relationView
  }
}
