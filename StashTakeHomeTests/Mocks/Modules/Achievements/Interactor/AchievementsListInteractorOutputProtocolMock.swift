//
//  AchievementsListInteractorOutputProtocolMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementsListInteractorOutputProtocolMock: AchievementsListInteractorOutputProtocol {
  // MARK: Public Properties
  var didFetchCalls: [(achievementsListTitle: String, achievementsList: [Achievement])] = []
  var didFailToFetchAchievementsListCallCount = 0

  // MARK: Public Methods
  func didFetch(achievementsListTitle: String, achievementsList: [Achievement]) {
    didFetchCalls.append((achievementsListTitle: achievementsListTitle, achievementsList: achievementsList))
  }

  func didFailToFetchAchievementsList() {
    didFailToFetchAchievementsListCallCount += 1
  }
}
