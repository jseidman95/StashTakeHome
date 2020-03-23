//
//  AchievementsListPresenterTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementsListPresenterTests: XCTestCase {
  var achievementsListPresenter: AchievementsListPresenter!
  var viewMock: AchievementsListViewProtocolMock!
  var interactorMock: AchievementsListInteractorInputProtocolMock!
  var routerMock: AchievementsListRouterProtocolMock!
  
  override func setUp() {
    routerMock = AchievementsListRouterProtocolMock()
    interactorMock = AchievementsListInteractorInputProtocolMock()
    viewMock = AchievementsListViewProtocolMock()
    achievementsListPresenter = AchievementsListPresenter()

    achievementsListPresenter.view = viewMock
    achievementsListPresenter.interactor = interactorMock
    achievementsListPresenter.router = routerMock
  }

  func testPresentAchievementsTellsTheInteractorToFetch() {
    achievementsListPresenter.presentAchievements()
    XCTAssertTrue(interactorMock.fetchAchievementsListCallCount == 1)
  }

  func testInfoButtonPressedTellsTheRouterToPresentTheInfoScreen() {
    achievementsListPresenter.infoButtonPressed()
    XCTAssertTrue(routerMock.presentInfoScreenCallCount == 1)
  }

  func testDidFetchAchievementListTellsTheViewToDisplayTitleAndShowList() {
    let string = TestHelper.randomString()
    let achievements = (1...10).map { _ in TestHelper.createRandomAchievement() }

    achievementsListPresenter.didFetch(achievementsListTitle: string, achievementsList: achievements)
    XCTAssertTrue(viewMock.displayTitleCalls.first == string)
    XCTAssertTrue(viewMock.showAchievementsCalls.first == achievements)
  }

  func testDidFailToFetchAchievementListTellsTheViewToShowTheNecessaryScreen() {
    achievementsListPresenter.didFailToFetchAchievementsList()
    XCTAssertTrue(viewMock.showNoAchievementsScreenCallCount == 1)
  }

  func testAchievementCellPressedCallsTheRouterToPresentTheDetailScreen() {
    let achievement = TestHelper.createRandomAchievement()

    achievementsListPresenter.achievementCellPressed(for: achievement)

    XCTAssert(routerMock.presentAchievementDetailCalls.first == achievement)

  }
}
