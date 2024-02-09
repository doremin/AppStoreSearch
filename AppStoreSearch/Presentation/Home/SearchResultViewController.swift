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
  private let dataSource: RxTableViewSectionedReloadDataSource<SearchResultSection>
  
  // MARK: Initializer
  init(
    viewModel: SearchResultViewModel,
    cellViewModelFacotry: @escaping (SearchResponse.SearchResult) -> SearchResultTableViewCellViewModel
  ) {
    self.viewModel = viewModel
    self.dataSource = Self.dataSourceFacotry(cellViewModelFacotry: cellViewModelFacotry)
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: DataSource Facotry
  private static func dataSourceFacotry(
    cellViewModelFacotry: @escaping (SearchResponse.SearchResult) -> SearchResultTableViewCellViewModel)
  -> RxTableViewSectionedReloadDataSource<SearchResultSection> {
    return .init(
      configureCell: { dataSource, tableView, indexPath, item in
        let dequeuedCell = tableView.dequeueReusableCell(
          withIdentifier: SearchResultTableViewCell.reuseIdentifier,
          for: indexPath)
        
        guard let cell = dequeuedCell as? SearchResultTableViewCell else {
          fatalError("SearchResultTalbeViewCell Casting Fail")
        }
        
        let viewModel = cellViewModelFacotry(item)
        cell.bind(viewModel: viewModel)
        
        return cell
      })
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
    tableView.rowHeight = 400
    tableView.separatorStyle = .none
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
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    output.isLoadingIndicatorActive
      .bind(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}
