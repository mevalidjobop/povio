//
//  FlowersDataSource.swift
//  FlowrSpot
//
//  Created by TK on 18/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import Foundation
import OrderedCollections
import PovioKit
import UIKit

class FlowersDataSource {
  typealias Section = FlowersSection
  typealias Row = AnyHashable
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
  
  private var diffableDataSource: DataSource?
  private var flowers = OrderedSet<Flower>()
}

// MARK: - Public Methods
extension FlowersDataSource {
  func update(flowers: [Flower]) {
    flowers.forEach { self.flowers.updateOrAppend($0) }
    build(animated: true)
  }
  
  func row(at indexPath: IndexPath) -> Row? {
    diffableDataSource?.itemIdentifier(for: indexPath)
  }
  
  func create(with collectionView: UICollectionView) -> DataSource? {
    diffableDataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, row in
      switch row {
      case let flowersRow as FlowersRow:
        let cell = collectionView.dequeueReusableCell(FlowerCollectionViewCell.self, at: indexPath)
        cell.update(with: flowersRow)
        return cell
      case _:
        return nil
      }
    }
    
    return diffableDataSource
  }
}

// MARK: - Private Methods
private extension FlowersDataSource {
  func build(animated: Bool) {
    let rows: [FlowersRow] = flowers.map(FlowersRow.init)
    
    var snapshot = Snapshot()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(rows)
    diffableDataSource?.apply(snapshot, animatingDifferences: animated)
  }
}
