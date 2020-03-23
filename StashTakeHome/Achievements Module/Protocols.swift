//
//  Protocols.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

protocol AchievementsListViewProtocol: class {
  var presenter: AchievementsListPresenterProtocol? { get set }

  func display(title: String)
  func show(achievements: [Achievement])
  func showNoAchievementsScreen()
}

protocol AchievementsListInteractorInputProtocol: class {
  var presenter: AchievementsListInteractorOutputProtocol? { get set }

  func fetchAchievementsList()
}

protocol AchievementsListInteractorOutputProtocol: class {
  func didFetch(achievementsListTitle: String, achievementsList: [Achievement])
  func didFailToFetchAchievementsList()
}

protocol AchievementsListPresenterProtocol: class {
  var view: AchievementsListViewProtocol? { get set }
  var interactor: AchievementsListInteractorInputProtocol? { get set }
  var router: AchievementsListRouterProtocol? { get set }

  func presentAchievements()
  func infoButtonPressed()
  func backButtonPressed()
}

protocol AchievementsListRouterProtocol: class {
  var presenter: AchievementsListPresenterProtocol? { get set }

  static func createAchievementListModule() -> UIViewController
  func presentInfoScreen()
  func dismissAchievementScreen()
}


