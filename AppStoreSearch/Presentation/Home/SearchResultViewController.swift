//
//  SearchResultViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

final class SearchResultViewController: BaseViewController {
  
  private let viewModel: SearchResultViewModel
  
  init(viewModel: SearchResultViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
}
