//
//  AchievementListInteractor.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementListInteractor: AchievementsListInteractorInputProtocol {
  // MARK: Private Properties
  private let dataManager: AchievementListDataManager

  // MARK: AchievementsListInteractorInputProtocol Properties
  weak var presenter: AchievementsListInteractorOutputProtocol?

  // MARK: Public Methods
  init(
    dataManager: AchievementListDataManager = .init()
  ) {
    self.dataManager = dataManager
  }

  // MARK: AchievementsListInteractorInputProtocol Methods
  func fetchAchievementsList() {
    self.dataManager.loadAchievementList { result in
      switch result {
      case .success((let title, let achievements)):
        self.presenter?.didFetch(achievementsListTitle: title, achievementsList: achievements)
      case .failure:
        self.presenter?.didFailToFetchAchievementsList()
      }
    }
  }
}
