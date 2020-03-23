//
//  HTTPStatus.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

struct HTTPStatus {
  let success: Bool
  let statusCode: Int
}

extension HTTPStatus: Decodable {
  enum CodingKeys: String, CodingKey {
    case success
    case statusCode = "status"
  }
}
