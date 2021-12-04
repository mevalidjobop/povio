//
//  Flower.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

struct Flower: Identifiable {
  let id: Int
  let name: String
  let latinName: String
  let sightings: Int
  let profilePicture: URL?
  let isFavorite: Bool
}

extension Flower: Equatable, Hashable {
  static func == (lhs: Flower, rhs: Flower) -> Bool {
    lhs.id == rhs.id
  }
}
