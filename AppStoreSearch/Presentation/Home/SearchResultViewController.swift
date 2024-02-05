//
//  SearchResultViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

import RxDataSources

final class SearchResultViewController: BaseViewController {
  
  // MARK: UI
  private let loadingIndicator = UIActivityIndicatorView(style: .large)
  private let tableView = UITableView()
  
  // MARK: Properties
  private let viewModel: SearchResultViewModel
  private let datsSource = RxTableViewSectionedReloadDataSource<SearchResultSection>(
    configureCell: { dataSource, tableView, indexPath, item in
      let dequeuedCell = tableView.dequeueReusableCell(
        withIdentifier: SearchResultTableViewCell.reuseIdentifier,
        for: indexPath)
      
      guard let cell = dequeuedCell as? SearchResultTableViewCell else {
        fatalError("SearchResultTalbeViewCell Casting Fail")
      }
      
      cell.config(title: item.trackName)
      
      return cell
    })
  
  // MARK: Initializer
  init(viewModel: SearchResultViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
   
  // MARK: TableView Setup
  private func setupTableView() {
    tableView.register(
      SearchResultTableViewCell.self,
      forCellReuseIdentifier: SearchResultTableViewCell.reuseIdentifier)
    tableView.rowHeight = 100
  }
  
  // MARK: Layout
  override func addSubviews() {
    view.add {
      tableView
      loadingIndicator
    }
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    loadingIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  override func bind() {
    let viewDidAppear = self.rx.viewDidAppear
      .asObservable()
    let input = SearchResultViewModel.Input(viewDidAppear: viewDidAppear)
    
    let output = viewModel.transform(input: input)
    
    output.backgroundColor
      .bind(to: view.rx.backgroundColor)
      .disposed(by: disposeBag)
    
    output.searchResponses
      .bind(to: tableView.rx.items(dataSource: datsSource))
      .disposed(by: disposeBag)
    
    output.isLoadingIndicatorActive
      .bind(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}
