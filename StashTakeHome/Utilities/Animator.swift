//
//  Animator.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class Animator {
  // MARK: Public Methods
  func animate(
    withDuration duration: TimeInterval,
    animations: @escaping () -> Void,
    completion: ((Bool) -> Void)?
  ) {
    UIView.animate(withDuration: duration, animations: animations, completion: completion)
  }
}
