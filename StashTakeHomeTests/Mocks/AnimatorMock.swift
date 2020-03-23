//
//  AnimatorMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AnimatorMock: Animator {
  var animateCalls: [(duration: TimeInterval, animations: () -> Void, completion: ((Bool) -> Void)?)] = []

  override func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
    animateCalls.append((duration: duration, animations: animations, completion: completion))
    completion?(true)
  }
}
