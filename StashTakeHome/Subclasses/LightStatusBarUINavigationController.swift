//
//  LightStatusBarUINavigationController.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class LightStatusBarUINavigationController: UINavigationController {
  // MARK: Public Properties
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
