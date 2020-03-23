//
//  Global Functions.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

func performOnMainQueue(block: @escaping () -> Void) {
  DispatchQueue.main.async {
    block()
  }
}
