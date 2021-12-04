//
//  UIImageView+FlowrSpot.swift
//  FlowrSpot
//
//  Created by Borut Tomazin on 20/11/2020.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
  func setImage(with url: URL?, placeholder: UIImage? = nil) {
    kf.indicatorType = .activity
    kf.setImage(with: url, placeholder: placeholder)
  }
}
