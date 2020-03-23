//
//  AchievementsListViewRouter.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementsListViewRouter: AchievementsListRouterProtocol {
  // MARK: AchievementsListRouterProtocol Properties
  var presenter: AchievementsListPresenterProtocol?

  // MARK: AchievementsListRouterProtocol Methods
  static func createAchievementListModule() -> UIViewController {
    let viewController = AchievementsListViewController()
    let presenter: AchievementsListPresenterProtocol & AchievementsListInteractorOutputProtocol = AchievementsListPresenter()
    let interactor = AchievementListInteractor()

    presenter.view = viewController
    presenter.interactor = interactor
    presenter.router = AchievementsListViewRouter()
    interactor.presenter = presenter
    viewController.presenter = presenter

    let rootViewController = UIViewController()
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.pushViewController(viewController, animated: false)

    return navController
  }

  func presentInfoScreen() {
  }
}
