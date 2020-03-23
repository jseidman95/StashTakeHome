//
//  ProgressBarViewMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class ProgressBarViewMock: ProgressBarView {
  // MARK: Public Properties
  var setProgressCalls: [CGFloat] = []

  // MARK: Public Methods
  override func setProgress(_ progressRatio: CGFloat) {
    setProgressCalls.append(progressRatio)
  }
}
