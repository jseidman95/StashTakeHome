//
//  AchievementsListPresenter.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementsListPresenter: AchievementsListPresenterProtocol, AchievementsListInteractorOutputProtocol {
  // MARK: AchievementsListPresenterProtocol Properties
  var view: AchievementsListViewProtocol?
  var interactor: AchievementsListInteractorInputProtocol?
  var router: AchievementsListRouterProtocol?

  // MARK: AchievementsListPresenterProtocol Methods
  func presentAchievements() {
    self.interactor?.fetchAchievementsList()
  }

  func infoButtonPressed() {
    self.router?.presentInfoScreen()
  }

  func backButtonPressed() {
    self.router?.dismissAchievementScreen()
  }

  func achievementCellPressed(for achievement: Achievement) {
    self.router?.presentAchievementDetail(for: achievement)
  }


  // MARK: AchievementsListInteractorOutputProtocol Methods
  func didFetch(achievementsListTitle: String, achievementsList: [Achievement]) {
    self.view?.display(title: achievementsListTitle)
    self.view?.show(achievements: achievementsList)
  }

  func didFailToFetchAchievementsList() {
    self.view?.showNoAchievementsScreen()
  }
}
