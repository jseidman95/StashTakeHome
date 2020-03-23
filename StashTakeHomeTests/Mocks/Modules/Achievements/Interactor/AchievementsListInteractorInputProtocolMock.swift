//
//  AchievementsListInteractorInputProtocolMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementsListInteractorInputProtocolMock: AchievementsListInteractorInputProtocol {
  // MARK: AchievementsListInteractorInputProtocol Properties
  var presenter: AchievementsListInteractorOutputProtocol?

  // MARK: Public Properties
  var fetchAchievementsListCallCount = 0

  // MARK: AchievementsListInteractorInputProtocol Methods
  func fetchAchievementsList() {
    fetchAchievementsListCallCount += 1
  }
}
