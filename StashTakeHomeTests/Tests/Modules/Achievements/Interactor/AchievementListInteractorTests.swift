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

  func testFetchAchievementsListShouldTellPresenterToShowAchievementsIfTheRequestSucceededWithOneOrMoreAchievement() {
    let string = TestHelper.randomString()
    let achievements = (1...5).map { _ in return TestHelper.createRandomAchievement() }
    achievementListDataManagerMock.loadAchievementListReturnValue = .success((string, achievements))

    achievementListInteractor.fetchAchievementsList()

    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFetchCalls.first?.achievementsListTitle == string)
    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFetchCalls.first?.achievementsList == achievements)
  }

  func testFetchAchievementsListShouldTellPresenterToShowNoAchievementsViewIfTheRequestSucceededWithNoAchievements() {
    let string = TestHelper.randomString()
    achievementListDataManagerMock.loadAchievementListReturnValue = .success((string, []))

    achievementListInteractor.fetchAchievementsList()

    XCTAssertTrue(achievementsListInteractorOutputProtocolMock.didFailToFetchAchievementsListCallCount == 1)
  }
}
