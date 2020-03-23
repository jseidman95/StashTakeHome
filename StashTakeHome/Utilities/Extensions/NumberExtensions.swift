//
//  NumberExtensions.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

// I use these to scale UI that can't easily use a multiplier (like label text for example)
// You design on the SE and multiply by this and it looks the same on other devices

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
