//
//  AchievementListResponse.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

struct AchievementListResponse {
  // MARK: Public Types
  struct Overview: Codable {
    let title: String
  }

  // MARK: Public Properties
  let status: HTTPStatus
  let overview: Overview
  let achievements: [Achievement]
}

extension AchievementListResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case overview, status, success, achievements
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.status = try HTTPStatus(from: decoder)
    self.overview = try container.decode(Overview.self, forKey: .overview)
    self.achievements = try container.decode([Achievement].self, forKey: .achievements)
  }
}
