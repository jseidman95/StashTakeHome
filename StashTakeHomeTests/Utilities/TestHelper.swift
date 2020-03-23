//
//  TestHelper.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class TestHelper {
  static func randomString() -> String {
    return UUID().uuidString
  }
}
