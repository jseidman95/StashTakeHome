//
//  ArrayExtension.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

extension Array {
  subscript(safe index: Index) -> Element? {
    guard index > startIndex && index < endIndex else { return nil }

    return self[index]
  }
}
