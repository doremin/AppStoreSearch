//
//  HomeViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController {
  
  // MARK: Properties
  private let viewModel: HomeViewModel
  
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
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
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
    tableView.rx.willBeginDragging
      .subscribe(with: self, onNext: { owner, _ in
        owner.searchController.isActive = false
      })
      .disposed(by: disposeBag)
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
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .asObservable()
    
    let textDidBeginEditing = searchController.searchBar
      .rx
      .textDidBeginEditing
      .asObservable()
    
    let textDidEndEditing = searchController.searchBar
      .rx
      .textDidEndEditing
      .asObservable()
    
    let input = HomeViewModel.Input(
      query: query,
      textDidBeginEditing: textDidBeginEditing,
      textDidEndEditing: textDidEndEditing)
    
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
  }
}

@available(iOS 17.0, *)
#Preview {
  let config = AppConfigurationImpl()
  let viewModel = HomeViewModel(appConfiguration: config)
  let homeViewController = HomeViewController(viewModel: viewModel)
  let controller = UINavigationController(rootViewController: homeViewController)
  return controller
}
