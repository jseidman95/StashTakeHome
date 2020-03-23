//
//  AchievementsListRouterProtocolMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementsListRouterProtocolMock: AchievementsListRouterProtocol {
  // MARK: AchievementsListRouterProtocol Properties
  var presenter: AchievementsListPresenterProtocol?

  // MARK: Public Properties
  var presentInfoScreenCallCount = 0

  // MARK: AchievementsListRouterProtocol Methods
  func presentInfoScreen() {
    presentInfoScreenCallCount += 1
  }

  static func createAchievementListModule() -> UIViewController {
    return UIViewController()
  }
}
