//
//  FlowersAPI+Endpoints.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

extension FlowersAPI {
  enum Endpoints: EndpointEncodable {
    case list
    case details(flowerid: Int)
    
    var path: Path {
      switch self {
      case .list:
        return "flowers"
      case .details(let flowerid):
        return "flowers/\(String(flowerid))"
      }
    }
  }
}
