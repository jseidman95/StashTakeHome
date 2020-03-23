//
//  AchievementsListViewControllerTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementsListViewControllerTests: XCTestCase {
  var achievementsListViewController: AchievementsListViewController!
  var collectionViewMock: UICollectionViewMock!
  var presenterMock: AchievementsListPresenterMock!

  override func setUp() {
    super.setUp()

    presenterMock = AchievementsListPresenterMock()
    collectionViewMock = UICollectionViewMock()
    achievementsListViewController = AchievementsListViewController(collectionView: collectionViewMock)

    achievementsListViewController.presenter = presenterMock
  }

  func testViewWillAppearTellsPresenterToPresentAchievements() {
    achievementsListViewController.viewWillAppear(true)
    XCTAssert(presenterMock.presentAchievementsCallCount == 1)
  }

  func testInfoButtonTappedRelaysInputToThePresenter() {
    achievementsListViewController.infoButtonTapped()
    XCTAssert(presenterMock.infoButtonPressedCallCount == 1)
  }

  func testBackButtonTappedRelaysInputToThePresenter() {
    achievementsListViewController.backButtonTapped()
    XCTAssert(presenterMock.backButtonPressedCallCount == 1)
  }

  func testCollectionViewCellForItemAtDequeuesAnAchievementListCollectionViewCellAndConfiguresIt() {
    let upperBound = 5
    let achievements = (1...upperBound).map { _ in TestHelper.createRandomAchievement() }
    let randomIndexPath = IndexPath(item: Int.random(in: 0..<upperBound), section: 0)
    let cellMock = AchievementListCollectionViewCellMock()

    achievementsListViewController.show(achievements: achievements)
    collectionViewMock.dequeueReusableCellReturnValue = cellMock

    let cell = achievementsListViewController.collectionView(collectionViewMock, cellForItemAt: randomIndexPath)
    XCTAssert(cell == cellMock)
    XCTAssert(collectionViewMock.dequeueReusableCellCalls.first?.identifier == "cellReuseID")
    XCTAssert(collectionViewMock.dequeueReusableCellCalls.first?.indexPath == randomIndexPath)
    XCTAssert(cellMock.configureCalls.first == achievements[randomIndexPath.item])
  }

  func testNumberOfSectionsIsAlwaysOne() {
    XCTAssert(achievementsListViewController.numberOfSections(in: collectionViewMock) == 1)
  }

  func testNumberOfItemsInSectionIsAlwaysEqualToTheShownAchievementsCount() {
    let upperBound = Int.random(in: 2...200)
    let achievements = (1...upperBound).map { _ in TestHelper.createRandomAchievement() }

    achievementsListViewController.show(achievements: achievements)
    XCTAssert(achievementsListViewController.collectionView(collectionViewMock, numberOfItemsInSection: Int.random(in: 5...500)) == upperBound)
  }

  func testMinimumLineSpacingForSectionAtIsAlwaysTheCorrectConstantValue() {
    XCTAssert(achievementsListViewController.collectionView(collectionViewMock, layout: UICollectionViewLayout(), minimumLineSpacingForSectionAt: Int.random(in: 1...500)) == 20.scaled())
  }

  func testSizeForItemAtIndexPathIsAlwaysTheCorrectProportions() {
    let randomIndexPath = IndexPath(item: Int.random(in: 0..<5), section: 0)
    let collectionViewSize = CGSize(width: CGFloat.random(in: 20...500), height: CGFloat.random(in: 20...500))
    collectionViewMock.frame.size = collectionViewSize

    let size = achievementsListViewController.collectionView(collectionViewMock, layout: UICollectionViewLayout(), sizeForItemAt: randomIndexPath)

    XCTAssert(size.width == collectionViewSize.width * 0.87)
    XCTAssert(size.height == collectionViewSize.width * 0.87 * 0.6)
  }

  func testShowAchievementsReloadsTheCollectionView() {
    let achievements = (1...5).map { _ in TestHelper.createRandomAchievement() }
    achievementsListViewController.show(achievements: achievements)
    XCTAssert(collectionViewMock.reloadDataCallCount == 1)
  }

  func testDisplayTitleChangesTheTitleOfTheViewController() {
    let string = TestHelper.randomString()
    achievementsListViewController.display(title: string)
    XCTAssert(achievementsListViewController.title == string)
  }
}
