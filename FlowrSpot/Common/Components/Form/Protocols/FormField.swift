//
//  FormField.swift
//  FlowrSpot
//
//  Created by Mirela V on 05/12/2021.
//  Copyright © 2021 Povio Labs. All rights reserved.
//

import UIKit

protocol FormField: AnyObject {
  var name: String? { get set }
  var title: String? { get set }
  var error: String? { get set }
  var rules: [Rule]? { get set }
}

extension TextField: FormField {}
