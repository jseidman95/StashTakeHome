//
//  UICollectionViewMock.swift
//  StashTakeHomeTests
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class UICollectionViewMock: UICollectionView {
  // MARK: Public Properties
  var dequeueReusableCellReturnValue: UICollectionViewCell = UICollectionViewCell()
  var dequeueReusableCellCalls: [(identifier: String, indexPath: IndexPath)] = []
  var reloadDataCallCount = 0
  var cellForItemCalls: [IndexPath] = []
  var cellForItemReturnValue: UICollectionViewCell?

  // MARK: Public Methods
  init() {
    super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
    dequeueReusableCellCalls.append((identifier: identifier, indexPath: indexPath))

    return dequeueReusableCellReturnValue
  }

  override func reloadData() {
    reloadDataCallCount += 1
  }

  override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
    cellForItemCalls.append(indexPath)
    return cellForItemReturnValue
  }
}
