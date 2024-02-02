//
//  BaseTableViewCell.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
  
  // MARK: Rx
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Layout
  func setupConstraints() {
    // Override point
  }
  
  func addSubviews() {
    // Overrride point
  }
}
