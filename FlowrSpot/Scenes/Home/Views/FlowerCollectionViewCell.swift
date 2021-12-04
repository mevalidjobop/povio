//
//  PhotoCollectionViewCell.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2020 Povio Labs. All rights reserved.
//

import PovioKit
import UIKit

class FlowerCollectionViewCell: UICollectionViewCell {
  private let imageView = UIImageView()
  private let favoriteButton = UIButton()
  private let stackView = UIStackView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let sightingsLabel = PaddingLabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    sightingsLabel.layer.cornerRadius = sightingsLabel.frame.height / 2
  }
}

// MARK: - Public methods
extension FlowerCollectionViewCell {
  func update(with row: FlowersRow) {
    titleLabel.text = row.name
    subtitleLabel.text = row.latinName
    sightingsLabel.text = row.sightingsCount
    imageView.setImage(with: row.profilePictureUrl)
  }
}

// MARK: - Private methods
private extension FlowerCollectionViewCell {
  func setupViews() {
    layer.masksToBounds = true
    layer.cornerRadius = 3
    setupImageView()
    setupFavoriteButton()
    setupStackView()
  }
  
  func setupImageView() {
    contentView.addSubview(imageView)
    imageView.kf.indicatorType = .activity
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.opacity = 0.8
    imageView.layer.addSublayer(gradientLayer)
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func setupFavoriteButton() {
    contentView.addSubview(favoriteButton)
    favoriteButton.backgroundColor = .white
    favoriteButton.layer.cornerRadius = 12
    favoriteButton.layer.masksToBounds = true
    favoriteButton.tintColor = .flowrDarkGray
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 12)
    let image = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
    favoriteButton.setImage(image, for: .normal)
    favoriteButton.snp.makeConstraints {
      $0.top.trailing.equalToSuperview().inset(16)
      $0.size.equalTo(24)
    }
  }
  
  func setupStackView() {
    func setupTitleLabel() {
      stackView.addArrangedSubview(titleLabel)
      titleLabel.font = .custom(type: .regular, size: 16)
      titleLabel.textColor = .white
      titleLabel.textAlignment = .center
      titleLabel.numberOfLines = 2
    }
    
    func setupSubtitleLabel() {
      stackView.addArrangedSubview(subtitleLabel)
      subtitleLabel.font = .custom(type: .italic, size: 10)
      subtitleLabel.textColor = .white
      subtitleLabel.textAlignment = .center
      subtitleLabel.alpha = 0.7
    }
    
    func setupSightingsLabel() {
      stackView.addArrangedSubview(sightingsLabel)
      sightingsLabel.contentInset = .init(top: 6, left: 12, bottom: 8, right: 12)
      sightingsLabel.font = .custom(type: .regular, size: 10)
      sightingsLabel.textColor = .white
      sightingsLabel.textAlignment = .center
      sightingsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      sightingsLabel.layer.masksToBounds = true
    }
    
    contentView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 9
    stackView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(16)
    }
    
    setupTitleLabel()
    setupSubtitleLabel()
    setupSightingsLabel()
    
    stackView.setCustomSpacing(15, after: subtitleLabel)
  }
}
