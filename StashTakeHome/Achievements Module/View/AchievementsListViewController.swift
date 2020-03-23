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
  private let infoButton: UIButton = .init(type: .infoLight)

  // MARK: Public Methods
  init(
    collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  ) {
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

    self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationController?.navigationBar.barTintColor = .stashNavigationBar
    self.navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: UIFont.systemFont(ofSize: 12)
    ]

    self.collectionView.contentInset = UIEdgeInsets(
      top: (self.navigationController?.navigationBar.frame.height ?? 0) + (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + 15,
      left: 0,
      bottom: 15,
      right: 0
    )
  }

  @objc func infoButtonTapped() {
    self.presenter?.infoButtonPressed()
  }

  // MARK: Private Methods
  private func setUpViews() {
    self.view.backgroundColor = .white
    setUpCollectionView()
    setUpInfoButton()
  }

  private func setUpCollectionView() {
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
    infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    infoButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
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
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width * 0.87
    let height = width * 0.6

    return CGSize(
      width: width,
      height: height
    )
  }

  // MARK: AchievementsListViewProtocol Methods
  func show(achievements: [Achievement]) {
    self.achievements = achievements
    self.collectionView.reloadData()
  }

  func showNoAchievementsScreen() {
    // TODO: Maybe implement this later
  }

  func display(title: String) {
    self.title = title
  }
}
