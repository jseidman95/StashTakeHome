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
  var noAchievementsFoundView: NoAchievementsFoundView!
  var animatorMock: AnimatorMock!

  override func setUp() {
    super.setUp()

    animatorMock = AnimatorMock()
    noAchievementsFoundView = NoAchievementsFoundView()
    presenterMock = AchievementsListPresenterMock()
    collectionViewMock = UICollectionViewMock()
    achievementsListViewController = AchievementsListViewController(collectionView: collectionViewMock, noAchievementsFoundView: noAchievementsFoundView, animator: animatorMock)

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

  func testShowAchievementsReloadsAndShowsTheCollectionView() {
    let achievements = (1...5).map { _ in TestHelper.createRandomAchievement() }
    achievementsListViewController.show(achievements: achievements)
    XCTAssert(collectionViewMock.reloadDataCallCount == 1)
    XCTAssert(collectionViewMock.isHidden == false)
    XCTAssert(noAchievementsFoundView.isHidden == true)
  }

  func testDisplayTitleChangesTheTitleOfTheViewController() {
    let string = TestHelper.randomString()
    achievementsListViewController.display(title: string)
    XCTAssert(achievementsListViewController.title == string)
  }

  func testShowNoAchievementsScreenHidesTheCollectionViewAndShowsTheNoAchievementsView() {
    achievementsListViewController.showNoAchievementsScreen()
    XCTAssert(collectionViewMock.isHidden == true)
    XCTAssert(noAchievementsFoundView.isHidden == false)
  }
//
//  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at: indexPath), self.achievements[safe: indexPath.item]?.unlocked == true else { return }
//    self.animate(cell: cell, withTransform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95), completion: {})
//  }
//
//  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at: indexPath), self.achievements[safe: indexPath.item]?.unlocked == true else { return }
//    self.animate(cell: cell, withTransform: CGAffineTransform.identity, completion: {})
//  }

  func testHighlightingItemPlaysAnimationIfItemIsUnlocked() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: true)
    ]
    let cell = UICollectionViewCell()
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didHighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.first?.duration == 0.2)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testHighlightingItemDoesntPlayAnimationIfItemIsLocked() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: false)
    ]
    let cell = UICollectionViewCell()
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didHighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testHighlightingItemDoesntPlayAnimationIfACellIsntReturned() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: false)
    ]
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = nil
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didHighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testUnhighlightingItemPlaysAnimationIfItemIsUnlocked() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: true)
    ]
    let cell = UICollectionViewCell()
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didUnhighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.first?.duration == 0.2)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testUnhighlightingItemDoesntPlayAnimationIfItemIsLocked() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: false)
    ]
    let cell = UICollectionViewCell()
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didUnhighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testUnighlightingItemDoesntPlayAnimationIfACellIsntReturned() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: false)
    ]
    let indexPath = IndexPath(item: 0, section: 0)

    collectionViewMock.cellForItemReturnValue = nil
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didUnhighlightItemAt: indexPath)

    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
  }

  func testSelectingCellTellsPresenterUnlockedAchievementWasSelected() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: true)
    ]
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = UICollectionViewCell()

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didSelectItemAt: indexPath)

    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
    XCTAssert(animatorMock.animateCalls.count == 2)
    XCTAssert(presenterMock.achievementCellPressedCalls.first == achievements[indexPath.item])
  }

  func testSelectingCellDoesNothingIfNoCellIsReturned() {
    let upperBound = 5
    let achievements = (1...upperBound).map { _ in TestHelper.createRandomAchievement() }
    let randomIndexPath = IndexPath(item: Int.random(in: 0..<upperBound), section: 0)

    collectionViewMock.cellForItemReturnValue = nil
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didSelectItemAt: randomIndexPath)

    XCTAssert(collectionViewMock.cellForItemCalls.first == randomIndexPath)
    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(presenterMock.achievementCellPressedCalls.isEmpty == true)
  }

  func testSelectingCellDoesNothingIfAchievementIsLocked() {
    let achievements = [
      Achievement(id: 0, level: "", progress: 0, total: 0, imageURL: URL(fileURLWithPath: ""), unlocked: false)
    ]
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = UICollectionViewCell()

    collectionViewMock.cellForItemReturnValue = cell
    achievementsListViewController.show(achievements: achievements)
    achievementsListViewController.collectionView(collectionViewMock, didSelectItemAt: indexPath)

    XCTAssert(collectionViewMock.cellForItemCalls.first == indexPath)
    XCTAssert(animatorMock.animateCalls.isEmpty == true)
    XCTAssert(presenterMock.achievementCellPressedCalls.isEmpty == true)
  }
}
