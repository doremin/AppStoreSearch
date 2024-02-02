//
//  SearchHistoryTableViewCell.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

final class SearchHistoryTableViewCell: BaseTableViewCell {
  
  // MARK: ReuseIdentifier
  static let reuseIdentifier = "SearchHistoryTableViewCell"
  
  // MARK: UI
  private let queryLabel: UILabel = {
    return .make(
      "",
      size: 16,
      color: .systemBlue)
  }()
  
  // MARK: Layout
  override func addSubviews() {
    contentView.add {
      queryLabel
    }
  }
  
  override func setupConstraints() {
    queryLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(30)
      make.centerY.equalToSuperview()
    }
  }
  
  func config(text: String) {
    queryLabel.text = text
  }
  
  override func prepareForReuse() {
    queryLabel.text = nil
  }
}

#Preview {
  let cell = SearchHistoryTableViewCell()
  cell.config(text: "TEST")
  return cell
}
