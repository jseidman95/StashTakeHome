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
  weak var presenter: AchievementsListPresenterProtocol?

  // MARK: Private Properties
  private weak var viewController: UIViewController?

  // MARK: AchievementsListRouterProtocol Methods
  func createAchievementListModule() -> UIViewController {
    let viewController = AchievementsListViewController()
    let presenter: AchievementsListPresenterProtocol & AchievementsListInteractorOutputProtocol = AchievementsListPresenter()
    let interactor = AchievementListInteractor()

    presenter.view = viewController
    presenter.interactor = interactor
    presenter.router = self
    interactor.presenter = presenter
    viewController.presenter = presenter

    let rootViewController = UIViewController()
    let navController = LightStatusBarUINavigationController(rootViewController: rootViewController)
    navController.pushViewController(viewController, animated: false)

    self.viewController = navController

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

  func presentAchievementDetail(for achievement: Achievement) {
    // No UI for this either but if there was the router would present the achievement detail
  }
}
