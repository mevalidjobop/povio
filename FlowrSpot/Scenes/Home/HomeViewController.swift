//
//  HomeViewController.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

protocol HomeDisplayLogic: AnyObject {
  func displayFlowers(_ flowers: [Flower])
  func displayError(title: String, message: String)
}

class HomeViewController: UIViewController {
  var interactor: HomeBusinessLogic?
  var router: HomeRoutingLogic?
  private lazy var contentView = HomeContentView()
  private let dataSource = FlowersDataSource()
  
  init(delegate: HomeRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    loadData()
  }
}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
  func displayFlowers(_ flowers: [Flower]) {
    dataSource.update(flowers: flowers)
    contentView.collectionView.reloadData()
    contentView.emptyView.isHidden = true
  }
  
  func displayError(title: String, message: String) {
    router?.navigateToAlert(title: title, message: message, handler: nil)
    contentView.emptyView.isHidden = false
  }
}

// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    contentView.collectionViewDimensions.sizeForItem(at: indexPath, for: collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let row = dataSource.row(at: indexPath) else {
      Logger.error("No availible row in dataSource at \(indexPath)")
      return
    }
    switch row {
    case let flowersRow as FlowersRow:
      router?.navigateToFlowerDetails(flower: flowersRow.entity)
    case _:
      break
    }
  }
}

// MARK: - UIScrollView Delegate
extension HomeViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    contentView.onScroll(offset: scrollView.contentOffset.y)
  }
}

// MARK: - Private methods
private extension HomeViewController {
  func setupViews() {
    navigationItem.title = "general_app_name".localized()
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contentView.rightBarButton)
    setupContentView()
  }
  
  func setupContentView() {
    contentView.rightBarButton.setImage(UIImage(named: "plIconSearch"), for: .normal)
    contentView.rightBarButton.addTarget(self, action: #selector(barButtonPressed), for: .touchUpInside)
    contentView.collectionView.delegate = self
    contentView.collectionView.dataSource = dataSource.create(with: contentView.collectionView)
  }
  
  func loadData() {
    interactor?.fetchFlowers()
  }
}

// MARK: - Actions
private extension HomeViewController {
  @objc func barButtonPressed() {
    contentView.collectionView.setContentOffset(.init(x: 0, y: -contentView.headerViewHeight), animated: true)
  }
}
