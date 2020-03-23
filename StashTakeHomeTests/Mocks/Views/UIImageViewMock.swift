//
//  UIImageViewMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
import SDWebImage

class UIImageViewMock: UIImageView {
  // MARK: Public Properties
  var sdSetImageCalls: [(url: URL?, placeholder: UIImage?, options: SDWebImageOptions, completedBlock: SDExternalCompletionBlock?)] = []

  override func sd_setImage(with url: URL?, placeholderImage placeholder: UIImage?, options: SDWebImageOptions = [], completed completedBlock: SDExternalCompletionBlock?) {
    sdSetImageCalls.append((url: url, placeholder: placeholder, options: options, completedBlock: completedBlock))
  }
}
