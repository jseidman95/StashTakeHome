//
//  AchievementsListViewController.swift
//  StashTakeHome
//
//  Created by Jesse Seidman on 3/22/20.
//  Copyright © 2020 Jesse Seidman. All rights reserved.
//

import UIKit

class AchievementsListViewController: UIViewController,
                                      AchievementsListViewProtocol,
                                      UICollectionViewDelegate,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
  // MARK: AchievementsListViewProtocol Properties
  var presenter: AchievementsListPresenterProtocol?

  // MARK: Private Properties
  private let collectionView: UICollectionView
  private var achievements: [Achievement] = []
  private let cellReuseID: String = "cellReuseID"
  private let infoButton: UIButton = .init()
  private let backButton: UIButton = .init()
  private let noAchievementsFoundView: NoAchievementsFoundView

  // MARK: Public Methods
  init(
    collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
    noAchievementsFoundView: NoAchievementsFoundView = .init()
  ) {
    self.noAchievementsFoundView = noAchievementsFoundView
    self.collectionView = collectionView
    super.init(nibName: nil, bundle: nil)
    self.setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.presenter?.presentAchievements()

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.barTintColor = UIColor.stashNavigationBar
    self.navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: UIFont.latoRegular(ofSize: 15.scaled())
    ]
  }

  @objc func infoButtonTapped() {
    self.presenter?.infoButtonPressed()
  }

  @objc func backButtonTapped() {
    self.presenter?.backButtonPressed()
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.view.backgroundColor = .white
    setUpCollectionView()
    setUpInfoButton()
    setUpBackButton()
    setUpNoAchievementsFoundView()
  }

  private func setUpCollectionView() {
    self.collectionView.contentInset = UIEdgeInsets(top: 15.scaled(), left: 0, bottom: 15.scaled(), right: 0)
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.backgroundColor = .clear
    collectionView.register(AchievementListCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(collectionView)
    NSLayoutConstraint.activate(
      [
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ]
    )
  }

  private func setUpInfoButton() {
    infoButton.tintColor = .white
    infoButton.setImage(UIImage(named: "info"), for: .normal)
    infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
  }

  private func setUpBackButton() {
    let image = UIImage(named: "arrow_left")?.withRenderingMode(.alwaysTemplate)
    backButton.tintColor = .white
    backButton.setImage(image, for: .normal)
    backButton.imageView?.contentMode = .scaleAspectFit
    backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
  }

  private func setUpNoAchievementsFoundView() {
    noAchievementsFoundView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(noAchievementsFoundView)
    NSLayoutConstraint.activate(
      [
        self.noAchievementsFoundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        self.noAchievementsFoundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        self.noAchievementsFoundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        self.noAchievementsFoundView.topAnchor.constraint(equalTo: self.view.topAnchor)
      ]
    )

    noAchievementsFoundView.isHidden = true
  }

  private func animate(cell: UICollectionViewCell, withTransform transform: CGAffineTransform, completion: @escaping () -> Void) {
    UIView.animate(
      withDuration: 0.2,
      animations: {
        cell.transform = transform
      },
      completion: { _ in completion() }
    )
  }

  // MARK: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? AchievementListCollectionViewCell else { return UICollectionViewCell() }

    if let achievement = self.achievements[safe: indexPath.item] {
      cell.configure(achievement: achievement)
    }

    return cell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return achievements.count
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20.scaled()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width * 0.87
    let height = width * 0.6

    return CGSize(
      width: width,
      height: height
    )
  }

  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath), self.achievements[safe: indexPath.item]?.unlocked == true else { return }
    self.animate(cell: cell, withTransform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95), completion: {})
  }

  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath), self.achievements[safe: indexPath.item]?.unlocked == true else { return }
    self.animate(cell: cell, withTransform: CGAffineTransform.identity, completion: {})
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath), self.achievements[safe: indexPath.item]?.unlocked == true else { return }

    self.animate(cell: cell, withTransform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)) {
      self.animate(cell: cell, withTransform: .identity, completion: {})
    }
  }

  // MARK: AchievementsListViewProtocol Methods
  func show(achievements: [Achievement]) {
    self.noAchievementsFoundView.isHidden = true
    self.collectionView.isHidden = false

    self.achievements = achievements
    self.collectionView.reloadData()
  }

  func showNoAchievementsScreen() {
    self.noAchievementsFoundView.isHidden = false
    self.collectionView.isHidden = true
  }

  func display(title: String) {
    self.title = title
  }
}
