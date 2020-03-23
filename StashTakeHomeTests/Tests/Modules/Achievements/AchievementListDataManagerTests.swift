//
//  AchievementListDataManagerTests.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import XCTest
@testable import StashTakeHome

class AchievementListDataManagerTests: XCTestCase {
  var achievementListDataManager: AchievementListDataManager!
  var jsonDecoderMock: JSONDecoderMock!
  var mainBundle: Bundle!
  // Normally id mock this but I ran into an interesting problem where the bundle in a Testing target
  // is different than the main target and if you try to specify the main bundle path explicitly
  // and use a subclass mock you get a exc bad access.  To work around I reference the main bundle directly

  override func setUp() {
    mainBundle = Bundle(path: Bundle.main.bundlePath)
    jsonDecoderMock = JSONDecoderMock()
  }

  func testLoadAchievementListFailsWithReadErrorIfItCantFindTheJSONFromTheBundle() {
    let expectation = XCTestExpectation(description: "load the list")
    let randomString = NSUUID().uuidString
    achievementListDataManager = AchievementListDataManager(
      listResourceName: randomString,
      bundle: mainBundle,
      decoder: jsonDecoderMock
    )

    achievementListDataManager.loadAchievementList { result in
      let resultFailedWithReadError: Bool
      switch result {
      case .failure(let error):
        switch error {
        case .readingError:
          resultFailedWithReadError = true
        default:
          resultFailedWithReadError = false
        }
      case .success:
        resultFailedWithReadError = false
      }

      XCTAssertTrue(resultFailedWithReadError)
      expectation.fulfill()
    }
  }

  func testLoadAchievementListFailsWithReadErrorIfTheGivenJSONIsMalformed() {
    let expectation = XCTestExpectation(description: "load the malformed list")
    achievementListDataManager = AchievementListDataManager(
      listResourceName: "malformed_achievements",
      bundle: Bundle(for: type(of: self)),
      decoder: jsonDecoderMock
    )

    achievementListDataManager.loadAchievementList { result in
      let resultFailedWithReadError: Bool
      switch result {
      case .failure(let error):
        switch error {
        case .readingError:
          resultFailedWithReadError = true
        default:
          resultFailedWithReadError = false
        }
      case .success:
        resultFailedWithReadError = false
      }

      XCTAssertTrue(resultFailedWithReadError)
      expectation.fulfill()
    }
  }

  func testLoadAchievementListFailsIfTheListResponseHasAnHTTPError() {
    let expectation = XCTestExpectation(description: "load the list")
    let statusCode = Int.random(in: 0...500)
    let achievementListResponse = AchievementListResponse(status: HTTPStatus(success: false, statusCode: statusCode), overview: AchievementListResponse.Overview(title: ""), achievements: [])
    jsonDecoderMock.decodeReturnValue = achievementListResponse
    achievementListDataManager = AchievementListDataManager(
      bundle: mainBundle,
      decoder: jsonDecoderMock
    )

    achievementListDataManager.loadAchievementList { result in
      let resultFailedWithHTTPError: Bool
      switch result {
      case .failure(let error):
        switch error {
        case .badResponse(let status):
          resultFailedWithHTTPError = true
          XCTAssertTrue(status.statusCode == statusCode)
        default:
          resultFailedWithHTTPError = false
        }
      case .success:
        resultFailedWithHTTPError = false
      }

      XCTAssertTrue(resultFailedWithHTTPError)
      expectation.fulfill()
    }
  }

  func testLoadAchievementListSucceedsAndReturnsParsedListResponse() {
    let expectation = XCTestExpectation(description: "load the list")
    let title = TestHelper.randomString()
    let achievements = (0...5).map { _ in
      Achievement(
        id: Int.random(in: 1...20),
        level: TestHelper.randomString(),
        progress: Int.random(in: 1...20),
        total: Int.random(in: 1...20),
        imageURL: URL(fileURLWithPath: TestHelper.randomString()),
        unlocked: Bool.random()
      )
    }

    let achievementListResponse = AchievementListResponse(
      status: HTTPStatus(success: true, statusCode: 0),
      overview: AchievementListResponse.Overview(title: title),
      achievements: achievements
    )

    jsonDecoderMock.decodeReturnValue = achievementListResponse
    achievementListDataManager = AchievementListDataManager(
      bundle: mainBundle,
      decoder: jsonDecoderMock
    )

    achievementListDataManager.loadAchievementList { result in
      let resultSucceeded: Bool
      switch result {
      case .failure:
        resultSucceeded = false
      case .success((let returnedTitle, let returnedAchievements)):
        resultSucceeded = true
        XCTAssertTrue(returnedTitle == title)
        XCTAssertTrue(
          returnedAchievements.elementsEqual(achievements) { (returnedAchievement, achievement) -> Bool in
            returnedAchievement.id == achievement.id &&
            returnedAchievement.level == achievement.level &&
            returnedAchievement.progress == achievement.progress &&
            returnedAchievement.total == achievement.total &&
            returnedAchievement.imageURL.absoluteString == achievement.imageURL.absoluteString &&
            returnedAchievement.unlocked == achievement.unlocked
          }
        )
      }

      XCTAssertTrue(resultSucceeded)
      expectation.fulfill()
    }
  }
}
