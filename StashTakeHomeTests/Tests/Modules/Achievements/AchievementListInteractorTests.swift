//
//  AchievementListInteractorTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementListInteractorTests: XCTestCase {
  var achievementListInteractor: AchievementListInteractor!
  var achievementListDataManagerMock: AchievementListDataManagerMock!
  var achievementsListInteractorOutputProtocolMock: AchievementsListInteractorOutputProtocolMock!

  override func setUp() {
    achievementsListInteractorOutputProtocolMock = AchievementsListInteractorOutputProtocolMock()
    achievementListDataManagerMock = AchievementListDataManagerMock()
    achievementListInteractor = AchievementListInteractor(dataManager: achievementListDataManagerMock)
    achievementListInteractor.presenter = achievementsListInteractorOutputProtocolMock
  }

  func testFetchAchievementsListShouldInformPresenterItFailedIfTheRequestFailed() {
    achievementListDataManagerMock.loadAchievementListReturnValue = .failure(AchievementListDataManager.FetchingError.readingError)
    achievementListInteractor.fetchAchievementsList()
    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFailToFetchAchievementsListCallCount == 1)
  }

  func testFetchAchievementsListShouldTellPresenterToShowAchievementsIfTheRequestSucceeded() {
    let string = TestHelper.randomString()
    let achievements = (1...5).map { _ in
      return Achievement(
        id: Int.random(in: 1...20),
        level: TestHelper.randomString(),
        progress: Points.random(in: 1...20),
        total: Points.random(in: 1...20),
        imageURL: URL(fileURLWithPath: TestHelper.randomString()),
        unlocked: Bool.random()
      )
    }
    achievementListDataManagerMock.loadAchievementListReturnValue = .success((string, achievements))

    achievementListInteractor.fetchAchievementsList()

    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFetchCalls.first?.achievementsListTitle == string)
    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFetchCalls.first?.achievementsList == achievements)
  }
}
