//
//  ModelMapper.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

protocol ModelMapper {
  associatedtype T
  associatedtype U
  static func map(response: [T]) -> [U]
  static func transform(response: T) -> U?
}

extension ModelMapper {
  static func map(response: [T]) -> [U] {
    response.compactMap { transform(response: $0) }
  }
}
