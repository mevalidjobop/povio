//
//  DataSource.swift
//  FlowrSpot
//
//  Created by Toni Kocjan on 18/01/2018.
//  Copyright © 2018 Povio Labs. All rights reserved.
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
    sections[safe: indexPath.section]?.row(at: indexPath.row)
  }
}

extension Array where Array.Element: SectionType {
  subscript(safe index: Int) -> Array.Element? {
    guard index >= 0 && index < count else { return nil }
    return self[index]
  }
}
