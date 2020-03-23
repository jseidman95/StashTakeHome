//
//  AchievementListDataManager.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementListDataManager {
  // MARK: Public Types
  enum FetchingError: Error {
    case badResponse(status: HTTPStatus)
    case readingError
  }

  // MARK: Private Static Properties
  private let listResourceName: String

  // MARK: Private Properties
  private let bundle: Bundle
  private let decoder: JSONDecoder

  // MARK: Public Methods
  init(
    listResourceName: String = "achievements",
    bundle: Bundle = .main,
    decoder: JSONDecoder = .init()
  ) {
    self.listResourceName = listResourceName
    self.bundle = bundle
    self.decoder = decoder
  }

  func loadAchievementList(completion: @escaping (Result<(String, [Achievement]), FetchingError>) -> Void) {
    guard let path = self.bundle.path(forResource: listResourceName, ofType: "json") else { return completion(.failure(.readingError)) }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      let achievementResponse = try self.decoder.decode(AchievementListResponse.self, from: data)

      if achievementResponse.status.success {
        completion(.success((achievementResponse.overview.title, achievementResponse.achievements)))
      } else {
        completion(.failure(.badResponse(status: achievementResponse.status)))
      }
    } catch {
      return completion(.failure(.readingError))
    }
  }
}
