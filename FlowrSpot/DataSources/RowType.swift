//
//  RowType.swift
//  FlowrSpot
//
//  Created by Toni Kocjan on 18/01/2018.
//  Copyright © 2018 Povio Labs. All rights reserved.
//

import Foundation

protocol RowType {
  var reuseIdentifier: String { get }
}

extension RowType {
  var reuseIdentifier: String {
    String(describing: self)
  }
}
