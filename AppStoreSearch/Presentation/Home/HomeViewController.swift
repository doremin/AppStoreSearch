//
//  HomeViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

final class HomeViewController: BaseViewController {
  
  // MARK: Properties
  private let viewModel: HomeViewModel
  private let searchResultViewControllerFactory: ((String) -> SearchResultViewController)?
  private let dataSource = RxTableViewSectionedReloadDataSource<SearchHistorySection>(
    configureCell: { dataSource, tableView, indexPath, item in
      let dequeuedCell = tableView.dequeueReusableCell(
        withIdentifier: SearchHistoryTableViewCell.reuseIdentifier,
        for: indexPath)
      
      guard let cell = dequeuedCell as? SearchHistoryTableViewCell else {
        fatalError("SearchHistoryTableViewCell Casting Fail")
      }
      
      cell.config(text: item.query)
      
      return cell
    },
    canEditRowAtIndexPath: { _, _ in true })
  
  // MARK: UI
  private let searchController = UISearchController()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .red
    return tableView
  }()
  
  // MARK: Binder
  private lazy var backgroundColorBinder: Binder<UIColor> = {
    return Binder(self) { [weak self] _, color in
      guard let self = self else { return }
      self.tableView.backgroundColor = color
      self.view.backgroundColor = color
    }
  }()
  
  // MARK: Initializer
  init(
    viewModel: HomeViewModel,
    searchResultViewControllerFactory: ((String) -> SearchResultViewController)?)
  {
    self.viewModel = viewModel
    self.searchResultViewControllerFactory = searchResultViewControllerFactory
    super.init()
    self.title = "Home"
    self.tabBarItem.image = UIImage(systemName: "house")
    self.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSearchController()
    setupTableView()
  }
  
  private func setupSearchController() {
    navigationItem.title = "Search"
    navigationItem.largeTitleDisplayMode = .automatic
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search App"
  }
  
  private func setupTableView() {
    tableView.register(
      SearchHistoryTableViewCell.self,
      forCellReuseIdentifier: SearchHistoryTableViewCell.reuseIdentifier)
  }
  
  // MARK: Layout
  override func addSubviews() {
    view.add {
      tableView
    }
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.top.equalTo(view.snp.top).offset(156)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  // MARK: Bind
  override func bind() {
    // input
    let query = searchController.searchBar
      .rx
      .text
      .orEmpty
      .filter { $0 != "" }
      .asObservable()
    
    let searchButtonClicked = searchController.searchBar
      .rx
      .searchButtonClicked
      .asObservable()
    
    let textDidBeginEditing = searchController.searchBar
      .rx
      .textDidBeginEditing
      .asObservable()
    
    let textDidEndEditing = searchController.searchBar
      .rx
      .textDidEndEditing
      .asObservable()
    
    let tableViewWillBeginDragging = tableView
      .rx
      .willBeginDragging
      .asObservable()
    
    let tableViewItemDeleted = tableView
      .rx
      .itemDeleted
      .asObservable()
    
    let tableViewItemSelected = tableView
      .rx
      .itemSelected
      .asObservable()
    
    let tableViewModelSelected = tableView
      .rx
      .modelSelected(SearchHistory.self)
      .asObservable()
    
    let input = HomeViewModel.Input(
      query: query,
      searchButtonClicked: searchButtonClicked,
      textDidBeginEditing: textDidBeginEditing,
      textDidEndEditing: textDidEndEditing,
      tableViewWillBeginDragging: tableViewWillBeginDragging,
      tableViewItemDeleted: tableViewItemDeleted,
      tableViewItemSelected: tableViewItemSelected,
      tableViewModelSelected: tableViewModelSelected)
    
    // output
    let output = viewModel.transform(input: input)
    
    output.tableViewTopOffset
      .subscribe(with: self, onNext: { owner, value in
        UIView.animate(withDuration: 0.3) {
          owner.tableView.snp.updateConstraints { make in
            make.top.equalTo(owner.view.snp.top).offset(value)
          }
          
          owner.view.layoutIfNeeded()
        }
      })
      .disposed(by: disposeBag)
    
    output.backgroundColor
      .bind(to: backgroundColorBinder)
      .disposed(by: disposeBag)
    
    output.searchHistories
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    output.searchControllerIsActive
      .bind(to: searchController.rx.isActive)
      .disposed(by: disposeBag)
    
    output.selectedModel
      .subscribe(with: self, onNext: { owner, modelInfo in
        let (indexPath, searchHistory) = modelInfo
        owner.tableView.deselectRow(at: indexPath, animated: true)
        owner.presentSearchResultViewController(query: searchHistory.query)
      })
      .disposed(by: disposeBag)
    
    output.queryWhenSearchButtonClicked
      .subscribe(with: self, onNext: { owner, query in
        owner.presentSearchResultViewController(query: query)
      })
      .disposed(by: disposeBag)
  }
  
  static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<SearchHistorySection> {
    .init(
      configureCell: { dataSource, tableView, indexPath, item in
        let dequeuedCell = tableView.dequeueReusableCell(
          withIdentifier: SearchHistoryTableViewCell.reuseIdentifier,
          for: indexPath)
        
        guard let cell = dequeuedCell as? SearchHistoryTableViewCell else {
          fatalError("SearchHistoryTableViewCell Casting Fail")
        }
        
        cell.config(text: item.query)
        
        return cell
      })
  }
  
  private func presentSearchResultViewController(query: String) {
    guard let vc = self.searchResultViewControllerFactory?(query) else {
      return
    }
    
    navigationController?.pushViewController(vc, animated: true)
  }
}

@available(iOS 17.0, *)
#Preview {
  let config = AppConfigurationImpl()
  let viewModel = HomeViewModel(appConfiguration: config)
  let homeViewController = HomeViewController(viewModel: viewModel, searchResultViewControllerFactory: nil)
  let controller = UINavigationController(rootViewController: homeViewController)
  return controller
}
