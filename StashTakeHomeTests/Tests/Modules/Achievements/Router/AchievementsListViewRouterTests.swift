//
//  AchievementsListViewRouterTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementsListViewRouterTests: XCTestCase {
  var achievementsListViewRouter: AchievementsListViewRouter!

  override func setUp() {
    achievementsListViewRouter = AchievementsListViewRouter()
  }

  func testCreateAchievementListModuleMakesTheCorrectViewControllerAndEmbedsItInANavController() {
    let module = achievementsListViewRouter.createAchievementListModule()

    XCTAssert(module is UINavigationController)
    XCTAssert((module as? UINavigationController)?.viewControllers[1] is AchievementsListViewController)

    let achievementsListViewController = (module as? UINavigationController)?.viewControllers[1] as? AchievementsListViewController
    let presenter = achievementsListViewController?.presenter

    XCTAssert(presenter != nil)
    XCTAssert(presenter?.view as? AchievementsListViewController == achievementsListViewController)
    XCTAssert(presenter?.interactor != nil)
    XCTAssert(presenter?.router != nil)
    XCTAssert(presenter?.interactor?.presenter != nil)
  }
}
