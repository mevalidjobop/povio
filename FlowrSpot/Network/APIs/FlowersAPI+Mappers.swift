//
//  FlowersAPI+Mappers.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 20/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

extension FlowersAPI {
  struct FlowersMapper: ModelMapper {
    static func transform(response: FlowersResponse) -> [Flower]? {
      response.flowers.map {
        Flower(id: $0.id,
               name: $0.name,
               latinName: $0.latinName,
               sightings: $0.sightings,
               profilePicture: URL(string: "http:\($0.profilePicture)"),
               isFavorite: $0.favorite)
      }
    }
  }
}
