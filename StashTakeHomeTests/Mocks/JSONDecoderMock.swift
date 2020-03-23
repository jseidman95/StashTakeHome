//
//  JSONDecoderMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class JSONDecoderMock: JSONDecoder {
  // MARK: Public Properties
  var decodeCalls: [(type: Any.Type, data: Data)] = []
  var decodeReturnValue: Decodable?

  // MARK: Public Methods
  override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
    decodeCalls.append((type: type, data: data))

    return try (decodeReturnValue as? T) ?? super.decode(type, from: data)
  }
}
