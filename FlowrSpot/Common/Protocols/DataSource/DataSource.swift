//
//  DataSource.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

protocol DataSource {
  associatedtype Section: SectionType
  var sections: [Section] { get set }
}

extension DataSource {
  func section(at index: Int) -> Self.Section? {
    sections[safe: index]
  }
  
  func numberOfSections() -> Int {
    sections.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    self.section(at: section)?.rows.count ?? 0
  }
  
  func row(at indexPath: IndexPath) -> Self.Section.Row? {
    section(at: indexPath.section)?.row(at: indexPath.row)
  }
}
