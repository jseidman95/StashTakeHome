//
//  AchievementListCollectionViewCell.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit
import SDWebImage

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
  private let pointsLabelsFont: UIFont = .latoRegular(ofSize: 13)
  private let pointsLabelsTextColor: UIColor = .white
  private let adjustedIntertextDistanceLevelCircleLabel: CGFloat = 5


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


    self.levelCircleView.layer.cornerRadius = self.levelCircleView.frame.height / 2

    let cornerRadius = self.frame.height * 0.03
    self.contentView.layer.cornerRadius = cornerRadius
    self.contentView.layer.masksToBounds = true

    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 10
    self.layer.shadowOpacity = 0.3
    self.layer.masksToBounds = false
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
  }

  func configure(achievement: Achievement) {
    self.contentView.alpha = achievement.unlocked ? 1.0 : 0.4
    self.setLevelCircleLabelText(withLevel: achievement.level)
    self.progressBar.setProgress(achievement.progressRatio)
    self.currentPointsLabel.text = "\(achievement.progress)pts"
    self.totalPointsLabel.text = "\(achievement.total)pts"
    self.backgroundImageView.sd_setImage(
      with: achievement.imageURL,
      placeholderImage: UIImage(named: "placeholder_image")
    )
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.backgroundColor = .clear
    setUpBackgroundImageView()
    setUpCurrentPointsLabel()
    setUpTotalPointsLabel()
    setUpProgressBar()
    setUpLevelCircleView()
    setUpLevelCircleLabel()
  }

  private func setUpBackgroundImageView() {
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(backgroundImageView)
    NSLayoutConstraint.activate(
      [
        self.backgroundImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
        self.backgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        self.backgroundImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
      ]
    )
  }

  private func setUpCurrentPointsLabel() {
    currentPointsLabel.textColor = pointsLabelsTextColor
    currentPointsLabel.font = pointsLabelsFont
    currentPointsLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(currentPointsLabel)
    NSLayoutConstraint.activate(
      [
        self.currentPointsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: progressBarEdgePadding),
        self.currentPointsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -pointsLabelsBottomPadding),
      ]
    )
  }

  private func setUpTotalPointsLabel() {
    totalPointsLabel.textColor = pointsLabelsTextColor
    totalPointsLabel.font = pointsLabelsFont
    totalPointsLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(totalPointsLabel)
    NSLayoutConstraint.activate(
      [
        self.totalPointsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -progressBarEdgePadding),
        self.totalPointsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -pointsLabelsBottomPadding),
      ]
    )
  }

  private func setUpProgressBar() {
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(progressBar)
    NSLayoutConstraint.activate(
      [
        self.progressBar.leadingAnchor.constraint(equalTo: self.currentPointsLabel.leadingAnchor),
        self.progressBar.trailingAnchor.constraint(equalTo: self.totalPointsLabel.trailingAnchor),
        self.progressBar.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.04),
        self.progressBar.bottomAnchor.constraint(equalTo: currentPointsLabel.topAnchor, constant: -10)
      ]
    )
  }

  private func setUpLevelCircleView() {
    levelCircleView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    levelCircleView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(levelCircleView)
    NSLayoutConstraint.activate(
      [
        self.levelCircleView.bottomAnchor.constraint(equalTo: self.progressBar.topAnchor, constant: -20),
        self.levelCircleView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        self.levelCircleView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
        self.levelCircleView.heightAnchor.constraint(equalTo: self.levelCircleView.widthAnchor)
      ]
    )
  }

  private func setUpLevelCircleLabel() {
    levelCircleLabel.textAlignment = .center
    levelCircleLabel.numberOfLines = 2
    levelCircleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(levelCircleLabel)
    NSLayoutConstraint.activate(
      [
        self.levelCircleLabel.centerYAnchor.constraint(equalTo: self.levelCircleView.centerYAnchor, constant: adjustedIntertextDistanceLevelCircleLabel),
        self.levelCircleLabel.centerXAnchor.constraint(equalTo: self.levelCircleView.centerXAnchor)
      ]
    )
  }

  private func setLevelCircleLabelText(withLevel level: String) {
    let fullAttributedString = NSMutableAttributedString(
      string: "Level\n",
      attributes: [
        .font: UIFont.latoRegular(ofSize: 14),
        .foregroundColor: UIColor.black
      ]
    )

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacingBefore = -adjustedIntertextDistanceLevelCircleLabel
    paragraphStyle.alignment = .center

    let levelNumberAttributedString = NSAttributedString(
      string: level,
      attributes: [
        .font: UIFont.helveticaBold(ofSize: 50),
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle
      ]
    )



    fullAttributedString.append(levelNumberAttributedString)

    self.levelCircleLabel.attributedText = fullAttributedString
  }
}
