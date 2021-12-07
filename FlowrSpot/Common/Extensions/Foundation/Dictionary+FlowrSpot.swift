//
//  Dictionary+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Mirela V on 07/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import Foundation

extension Dictionary {
  func decode<T: Decodable>(_ : T.Type) -> T? {
    guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
    do {
      let decoded = try JSONDecoder().decode(T.self, from: data)
      return decoded
    } catch {
      return nil
    }
  }
}
