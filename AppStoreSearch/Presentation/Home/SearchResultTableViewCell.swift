//
//  SearchResultTableViewCell.swift
//  AppStoreSearch
//
//  Created by doremin on 2/5/24.
//

import UIKit

final class SearchResultTableViewCell: BaseTableViewCell {
  // MARK: ReuseIdentifier
  static let reuseIdentifier = "SearchResultTalbeViewCell"
  
  // MARK: UI
  private let appTitleLabel: UILabel = {
    return .make(
      "",
      size: 16,
      color: .systemBlue)
  }()
  
  // MARK: Layout
  override func addSubviews() {
    contentView.add {
      appTitleLabel
    }
  }
  
  override func setupConstraints() {
    appTitleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  func config(title: String) {
    appTitleLabel.text = title
  }
  
  // MARK: Prepare For Reuse
  override func prepareForReuse() {
    
  }
}
