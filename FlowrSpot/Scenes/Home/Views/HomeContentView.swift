//
//  HomeContentView.swift
//  FlowrSpot
//
//  Created by Toni Kocjan on 12/06/2019.
//  Copyright © 2019 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

class HomeContentView: UIView {
  let collectionViewDimensions = FlowerCollectionViewItemDimenson(numberOfItemsInRow: 2, insets: 8)
  let headerViewHeight: CGFloat = 255
  let headerView = HomeHeaderView()
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  let rightBarButton = UIButton(type: .custom)
  let emptyView = EmptyView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public Methods
extension HomeContentView {
  func onScroll(offset: CGFloat) {
    let percentage = 1 - (-offset / headerViewHeight)
    
    var headerViewTranslation = -percentage * headerViewHeight
    if headerViewTranslation > 0 {
      headerViewTranslation = 0 // lock headerView
    }
    
    headerView.transform = .identity.translatedBy(x: 0, y: headerViewTranslation)
    
    switch percentage {
    case 0.75...:
      showSearchButton()
    case _:
      hideSearchButton()
    }
  }
  
  func showSearchButton() {
    guard rightBarButton.alpha == 0 else { return }
    
    let transform = CATransform3DRotate(CATransform3DIdentity, 0, 1, 0, 0)
    UIView.animate(withDuration: 0.3) {
      self.rightBarButton.layer.transform = transform
      self.rightBarButton.alpha = 1
    }
  }
  
  func hideSearchButton() {
    guard rightBarButton.alpha == 1 else { return }
    
    let transform = CATransform3DRotate(CATransform3DIdentity, .pi, 1, 0, 0)
    UIView.animate(withDuration: 0.3) {
      self.rightBarButton.alpha = 0
      self.rightBarButton.layer.transform = transform
    }
  }
}

// MARK: - Private Methods
private extension HomeContentView {
  func setupViews() {
    backgroundColor = .white
    setupCollectionView()
    setupHeaderView()
    setupEmptyView()
  }
  
  func setupCollectionView() {
    addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.keyboardDismissMode = .onDrag
    collectionView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    collectionView.register(FlowerCollectionViewCell.self)
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout).map {
      $0.scrollDirection = .vertical
      $0.sectionInset = collectionViewDimensions.sectionInset
      $0.minimumLineSpacing = collectionViewDimensions.lineSpacing
      $0.minimumInteritemSpacing = collectionViewDimensions.interItemSpacing
    }
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func setupHeaderView() {
    addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(headerViewHeight)
    }
  }
  
  func setupEmptyView() {
    addSubview(emptyView)
    emptyView.text = "placeholder_no_content".localized()
    emptyView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
