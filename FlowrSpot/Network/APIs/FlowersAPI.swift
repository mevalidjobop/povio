//
//  FlowersAPI.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

class FlowersAPI {
  private let client: AlamofireNetworkClient
  
  init(client: AlamofireNetworkClient = .default) {
    self.client = client
  }
  
  func fetchFlowersList() -> Promise<[Flower]> {
    client
      .request(method: .get, endpoint: Endpoints.list)
      .validate()
      .decode(FlowersResponse.self, decoder: .default)
      .compactMap(with: FlowersMapper.transform)
  }
  
  func fetchFlowerDetails(flowerId: Int) -> Promise<FlowerResponse> {
    client
      .request(method: .get, endpoint: Endpoints.details(flowerid: flowerId))
      .validate()
      .decode(FlowerResponse.self, decoder: .default)
  }
}
