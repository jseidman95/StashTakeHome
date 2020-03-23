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
    let navController = LightStatusBarUINavigationController(rootViewController: rootViewController)
    navController.pushViewController(viewController, animated: false)

    return navController
  }

  func presentInfoScreen() {
    // There was no UI given for this screen but if there was, the wireframing and routing to
    // that screen would go here
  }

  func dismissAchievementScreen() {
    // We don't actually want to dismiss this screen because the previous screen is empty
    // but this is where the routing would go to dismiss this screen
  }
}
