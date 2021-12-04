//
//  SectionType.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

protocol SectionType {
  associatedtype Row: RowType
  var rows: [Row] { get }
}

extension SectionType {
  func row(at index: Int) -> Self.Row? {
    rows[safe: index]
  }
}
