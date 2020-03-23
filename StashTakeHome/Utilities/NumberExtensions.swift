//
//  NumberExtensions.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

extension CGFloat {
  func scaled() -> CGFloat {
    return self * iphoneSEScaleFactor
  }
}

extension Int {
  func scaled() -> CGFloat {
    return CGFloat(self) * iphoneSEScaleFactor
  }
}
