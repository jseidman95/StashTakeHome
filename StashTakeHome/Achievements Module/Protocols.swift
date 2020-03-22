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

  func show(achievements: [Achievement])
  func showNoAchievementsScreen()
}

protocol AchievementsListInteractorProtocol: class {
  var presenter: AchievementsListPresenterProtocol? { get set }

  func fetchAchievementsList()
}

protocol AchievementsListPresenterProtocol: class {
  var view: AchievementsListViewProtocol? { get set }
  var interactor: AchievementsListInteractorProtocol? { get set }
  var router: AchievementsListRouterProtocol? { get set }

  func presentAchievements()
  func infoButtonPressed()
}

protocol AchievementsListRouterProtocol: class {
  var presenter: AchievementsListPresenterProtocol? { get set }

  func createAchievementListModule(completion: (AchievementsListViewController) -> Void)
  func presentInfoScreen()
}


