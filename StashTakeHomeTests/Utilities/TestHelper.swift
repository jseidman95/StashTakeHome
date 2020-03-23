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
  // MARK: Public Static Functions
  static func randomString() -> String {
    return UUID().uuidString
  }

  static func createRandomAchievement() -> Achievement {
    return Achievement(
      id: Int.random(in: 1...20),
      level: TestHelper.randomString(),
      progress: Int.random(in: 1...20),
      total: Int.random(in: 1...20),
      imageURL: URL(fileURLWithPath: TestHelper.randomString()),
      unlocked: Bool.random()
    )
  }
}
