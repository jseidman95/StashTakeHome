//
//  Achievement.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

typealias Points = Int

struct Achievement: Equatable {
  let id: Int
  let level: String
  let progress: Points
  let total: Points
  let imageURL: URL
  let unlocked: Bool

  var progressRatio: CGFloat {
    return CGFloat(progress) / CGFloat(total)
  }
}

extension Achievement: Decodable {
  private enum CodingKeys: String, CodingKey {
    case id, level, progress, total
    case imageURL = "bg_image_url"
    case unlocked = "accessible"
  }
}
