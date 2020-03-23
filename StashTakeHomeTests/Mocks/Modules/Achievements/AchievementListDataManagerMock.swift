//
//  AchievementListDataManagerMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementListDataManagerMock: AchievementListDataManager {
  // MARK: Public Properties
  var loadAchievementListCallCount = 0
  var loadAchievementListReturnValue: Result<(String, [Achievement]), AchievementListDataManager.FetchingError> = .success(("", []))

  // MARK: Public Methods
  override func loadAchievementList(completion: @escaping (Result<(String, [Achievement]), AchievementListDataManager.FetchingError>) -> Void) {
    loadAchievementListCallCount += 1

    completion(loadAchievementListReturnValue)
  }
}
