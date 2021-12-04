//
//  FlowerRow.swift
//  FlowrSpot
//
//  Created by TK on 19/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

struct FlowersRow: Hashable {
  let entity: Flower
}

extension FlowersRow {
  var name: String { entity.name }
  var latinName: String { entity.latinName }
  var sightingsCount: String { "sightings_count".localized(entity.sightings) }
  var profilePictureUrl: URL? { entity.profilePicture }
}
