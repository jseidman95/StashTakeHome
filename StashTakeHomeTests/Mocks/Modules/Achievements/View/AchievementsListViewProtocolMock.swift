//
//  AchievementsListViewProtocolMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementsListViewProtocolMock: AchievementsListViewProtocol {
  // MARK: AchievementsListViewProtocol Properties
  var presenter: AchievementsListPresenterProtocol?

  // MARK: Public Properties
  var displayTitleCalls: [String] = []
  var showAchievementsCalls: [[Achievement]] = []
  var showNoAchievementsScreenCallCount = 0

  func display(title: String) {
    displayTitleCalls.append(title)
  }

  func show(achievements: [Achievement]) {
    showAchievementsCalls.append(achievements)
  }

  func showNoAchievementsScreen() {
    showNoAchievementsScreenCallCount += 1
  }
}
