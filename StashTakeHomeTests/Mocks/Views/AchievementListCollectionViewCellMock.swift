//
//  AchievementListCollectionViewCellMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
@testable import StashTakeHome

class AchievementListCollectionViewCellMock: AchievementListCollectionViewCell {
  // MARK: Public Properties
  var configureCalls: [Achievement] = []

  // MARK: Public Methods
  override func configure(achievement: Achievement) {
    configureCalls.append(achievement)
  }
}
