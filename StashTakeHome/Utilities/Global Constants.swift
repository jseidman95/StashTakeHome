//
//  Global Constants.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

// I use this to scale UI that can't easily use a multiplier (like label text)
// You design on the SE and multiply by this and it looks the same on other devices
var iphoneSEScaleFactor: CGFloat {
  return UIScreen.main.bounds.width / 320
}
