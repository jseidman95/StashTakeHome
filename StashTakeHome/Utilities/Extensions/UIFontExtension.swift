//
//  UIFontExtension.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

extension UIFont {
  static func latoRegular(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Regular", size: size) ?? UIFont()
  }

  static func latoBold(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Bold", size: size) ?? UIFont()
  }

  static func helveticaBold(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Helvetica-Bold", size: size) ?? UIFont()
  }
}
