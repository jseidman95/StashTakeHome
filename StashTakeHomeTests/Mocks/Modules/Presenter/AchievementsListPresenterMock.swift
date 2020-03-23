//
//  AchievementsListPresenterMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementsListPresenterMock: AchievementsListPresenter {
  // MARK: Public Properties
  var presentAchievementsCallCount = 0
  var infoButtonPressedCallCount = 0
  var backButtonPressedCallCount = 0

  // MARK: Public Methods
  override func presentAchievements() {
    presentAchievementsCallCount += 1
  }

  override func infoButtonPressed() {
    infoButtonPressedCallCount += 1
  }

  override func backButtonPressed() {
    backButtonPressedCallCount += 1
  }
}
