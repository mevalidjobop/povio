//
//  JSONDecoder+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Toni Kocjan on 12/06/2019.
//  Copyright © 2019 Povio Labs. All rights reserved.
//

import Foundation

extension JSONDecoder {
  static var `default`: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
}
