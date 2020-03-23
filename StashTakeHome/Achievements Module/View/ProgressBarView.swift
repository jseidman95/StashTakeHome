//
//  ProgressBarView.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
class ProgressBarView: UIView {
  // MARK: Private Properties
  private let progressBarFillView: UIView = .init(frame: .zero)
  private let fillColor: UIColor
  private var widthConstraint: NSLayoutConstraint?

  // MARK: Public Methods
  init(
    fillColor: UIColor = UIColor(red: 113 / 255.0, green: 202 / 255.0, blue: 92 / 255.0, alpha: 1.0)
  ) {
    self.fillColor = fillColor
    super.init(frame: .zero)
    self.setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.clipsToBounds = true
    self.layer.cornerRadius = self.frame.height / 2

    self.progressBarFillView.clipsToBounds = true
    self.progressBarFillView.layer.cornerRadius = self.frame.height / 2
  }

  func setProgress(_ progressRatio: CGFloat) {
    if let widthConstraint = widthConstraint {
      NSLayoutConstraint.deactivate([widthConstraint])
      self.removeConstraint(widthConstraint)
    }

    let newWidthConstraint = self.progressBarFillView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: progressRatio)
    NSLayoutConstraint.activate([newWidthConstraint])

    self.widthConstraint = newWidthConstraint
    self.layoutIfNeeded()
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.backgroundColor = .white
    setUpProgressBarFillView()
  }

  private func setUpProgressBarFillView() {
    progressBarFillView.translatesAutoresizingMaskIntoConstraints = false
    progressBarFillView.backgroundColor = fillColor
    self.addSubview(progressBarFillView)
    let widthConstraint = self.progressBarFillView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0)
    NSLayoutConstraint.activate(
      [
        self.progressBarFillView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.progressBarFillView.topAnchor.constraint(equalTo: self.topAnchor),
        self.progressBarFillView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        widthConstraint
      ]
    )

    self.widthConstraint = widthConstraint
  }
}
