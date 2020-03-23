//
//  NoAchievementsFoundView.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/23/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class NoAchievementsFoundView: UIView {
  // MARK: Private Properties
  private let label: UILabel = .init()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)
    self.setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.backgroundColor = .white
    setUpLabel()
  }

  private func setUpLabel() {
    label.numberOfLines = 2
    label.text = "No Achievements Found \n Please try again later"
    label.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(label)
    NSLayoutConstraint.activate(
      [
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
      ]
    )
  }
}
