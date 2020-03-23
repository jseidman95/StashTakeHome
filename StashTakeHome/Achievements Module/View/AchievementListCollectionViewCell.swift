//
//  AchievementListCollectionViewCell.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementListCollectionViewCell: UICollectionViewCell {
  // MARK: Private Properties
  private let backgroundImageView: UIImageView
  private let levelCircleView: UIView = .init(frame: .zero)
  private let levelCircleLabel: UILabel
  private let progressBar: ProgressBarView
  private let currentPointsLabel: UILabel
  private let totalPointsLabel: UILabel

  private let progressBarEdgePadding: CGFloat = 10
  private let pointsLabelsBottomPadding: CGFloat = 20
  private let pointsLabelsFont: UIFont = .boldSystemFont(ofSize: 12)
  private let pointsLabelsTextColor: UIColor = .white


  // MARK: Public Methods
  override init(frame: CGRect) {
    self.backgroundImageView = .init(frame: .zero)
    self.levelCircleLabel = .init(frame: .zero)
    self.currentPointsLabel = .init(frame: .zero)
    self.totalPointsLabel = .init(frame: .zero)
    self.progressBar = .init()
    super.init(frame: frame)
    self.setUpViews()
  }

  init(
    backgroundImageView: UIImageView = .init(frame: .zero),
    levelCircleLabel: UILabel = .init(frame: .zero),
    progressBar: ProgressBarView = .init(),
    currentPointsLabel: UILabel = .init(frame: .zero),
    totalPointsLabel: UILabel = .init(frame: .zero)
  ) {
    self.levelCircleLabel = levelCircleLabel
    self.backgroundImageView = backgroundImageView
    self.progressBar = progressBar
    self.currentPointsLabel = currentPointsLabel
    self.totalPointsLabel = totalPointsLabel
    super.init(frame: .zero)
    self.setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.levelCircleView.layer.cornerRadius = self.frame.height / 2

    self.layer.cornerRadius = self.frame.height * 0.1
    self.layer.backgroundColor = UIColor.clear.cgColor
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 10
    self.layer.shadowOpacity = 0.3
    self.layer.masksToBounds = false
  }

  func configure(achievement: Achievement) {
    self.setLevelCircleLabelText(withLevel: achievement.level)
    self.progressBar.setProgress(achievement.progressRatio)
    self.currentPointsLabel.text = "\(achievement.progress)pts"
    self.totalPointsLabel.text = "\(achievement.total)pts"
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.backgroundColor = .clear
    setUpBackgroundImageView()
    setUpLevelCircleView()
    setUpLevelCircleLabel()
    setUpCurrentPointsLabel()
    setUpTotalPointsLabel()
    setUpProgressBar()
  }

  private func setUpBackgroundImageView() {
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(backgroundImageView)
    NSLayoutConstraint.activate(
      [
        self.backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
        self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        self.backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor)
      ]
    )
  }

  private func setUpLevelCircleView() {
    levelCircleView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(levelCircleView)
    NSLayoutConstraint.activate(
      [
        self.levelCircleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        self.levelCircleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.levelCircleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
        self.levelCircleView.widthAnchor.constraint(equalTo: self.levelCircleView.heightAnchor)
      ]
    )
  }

  private func setUpLevelCircleLabel() {
    levelCircleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(levelCircleLabel)
    NSLayoutConstraint.activate(
      [
        self.levelCircleView.centerYAnchor.constraint(equalTo: self.levelCircleView.centerYAnchor),
        self.levelCircleView.centerXAnchor.constraint(equalTo: self.levelCircleView.centerXAnchor)
      ]
    )
  }

  private func setUpCurrentPointsLabel() {
    currentPointsLabel.textColor = pointsLabelsTextColor
    currentPointsLabel.font = pointsLabelsFont
    currentPointsLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(currentPointsLabel)
    NSLayoutConstraint.activate(
      [
        self.currentPointsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: progressBarEdgePadding),
        self.currentPointsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -pointsLabelsBottomPadding),
      ]
    )
  }

  private func setUpTotalPointsLabel() {
    totalPointsLabel.textColor = pointsLabelsTextColor
    totalPointsLabel.font = pointsLabelsFont
    totalPointsLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(totalPointsLabel)
    NSLayoutConstraint.activate(
      [
        self.totalPointsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -progressBarEdgePadding),
        self.totalPointsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -pointsLabelsBottomPadding),
      ]
    )
  }

  private func setUpProgressBar() {
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(progressBar)
    NSLayoutConstraint.activate(
      [
        self.progressBar.leadingAnchor.constraint(equalTo: self.currentPointsLabel.leadingAnchor),
        self.progressBar.trailingAnchor.constraint(equalTo: self.currentPointsLabel.trailingAnchor),
        self.progressBar.heightAnchor.constraint(equalToConstant: 10),
        self.progressBar.bottomAnchor.constraint(equalTo: currentPointsLabel.topAnchor, constant: -10)
      ]
    )
  }

  private func setLevelCircleLabelText(withLevel level: String) {
    let fullAttributedString = NSMutableAttributedString(
      string: "Level\n",
      attributes: [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.black
      ]
    )

    let levelNumberAttributedString = NSAttributedString(
      string: level,
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 17),
        .foregroundColor: UIColor.black
      ]
    )

    fullAttributedString.append(levelNumberAttributedString)

    self.levelCircleLabel.attributedText = fullAttributedString
  }
}
