//
//  EndpointEncodable.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 16/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation
import PovioKitNetworking

protocol EndpointEncodable: URLConvertible {
  typealias Path = String
  
  var path: Path { get }
  var url: String { get }
}

extension EndpointEncodable {
  var url: String {
    "\(Host.current.baseURL)/\(Version.v1.rawValue)/\(path)"
  }
  
  func asURL() throws -> URL {
    .init(stringLiteral: url)
  }
}

extension EndpointEncodable where Self: RawRepresentable, Self.RawValue == String {
  var path: String {
    rawValue
  }
}
