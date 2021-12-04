//
//  FlowersAPI+Models.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

extension FlowersAPI {
  struct FlowersResponse: Decodable {
    let flowers: [FlowerResponse]
  }
  
  struct FlowerResponse: Decodable {
    let id: Int
    let name: String
    let latinName: String
    let sightings: Int
    let profilePicture: String
    let favorite: Bool
  }
}
