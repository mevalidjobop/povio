//
//  HomeInteractor.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
  func fetchFlowers()
}

class HomeInteractor {
  var presenter: HomePresentationLogic?
  private let flowersAPI: FlowersAPI
  
  init(flowersAPI: FlowersAPI = .init()) {
    self.flowersAPI = flowersAPI
  }
}

// MARK: - Business Logic
extension HomeInteractor: HomeBusinessLogic {
  func fetchFlowers() {
    flowersAPI
      .fetchFlowersList()
      .observe { [weak self] in self?.presenter?.presentFlowersResult($0) }
  }
}
