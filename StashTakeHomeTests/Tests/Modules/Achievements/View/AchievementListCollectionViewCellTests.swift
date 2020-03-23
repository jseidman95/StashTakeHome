//
//  AchievementListCollectionViewCellTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementListCollectionViewCellTests: XCTestCase {
  var achievementListCollectionViewCell: AchievementListCollectionViewCell!
  var imageViewMock: UIImageViewMock!
  var progressBarMock: ProgressBarViewMock!
  var levelCircleLabel: UILabel!
  var currentPointsLabel: UILabel!
  var totalPointsLabel: UILabel!

  override func setUp() {
    imageViewMock = UIImageViewMock()
    progressBarMock = ProgressBarViewMock()
    levelCircleLabel = UILabel()
    currentPointsLabel = UILabel()
    totalPointsLabel = UILabel()

    achievementListCollectionViewCell = AchievementListCollectionViewCell(
      backgroundImageView: imageViewMock,
      levelCircleLabel: levelCircleLabel,
      progressBar: progressBarMock,
      currentPointsLabel: currentPointsLabel,
      totalPointsLabel: totalPointsLabel
    )
  }

  func testConfigureUpdatesTheUIWithTheAchievementData() {
    let achievement = TestHelper.createRandomAchievement()
    achievementListCollectionViewCell.configure(achievement: achievement)
    XCTAssert(levelCircleLabel.attributedText?.string == "Level\n\(achievement.level)")
    XCTAssert(progressBarMock.setProgressCalls.first == achievement.progressRatio)
    XCTAssert(currentPointsLabel.text == "\(achievement.progress)pts")
    XCTAssert(totalPointsLabel.text == "\(achievement.total)pts")
    XCTAssert(imageViewMock.sdSetImageCalls.first?.url?.absoluteString == achievement.imageURL.absoluteString)
    XCTAssert(imageViewMock.sdSetImageCalls.first?.placeholder == UIImage(named: "placeholder_image"))
  }
}
