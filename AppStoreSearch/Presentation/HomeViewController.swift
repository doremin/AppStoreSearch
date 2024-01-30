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
  private let appConfiguration: AppConfiguration
  
  // MARK: UI
  private let searchController = UISearchController()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .red
    return tableView
  }()
  
  // MARK: Initializer
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
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
    
    bindAppConfiguration()
    setupSearchController()
  }
  
  // MARK: Bind
  private func bindAppConfiguration() {
    appConfiguration.backgroundColor
      .bind(to: view.rx.backgroundColor)
      .disposed(by: disposeBag)
  }
  
  private func setupSearchController() {
    navigationItem.title = "Search"
    navigationItem.largeTitleDisplayMode = .automatic
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search App"
    
    searchController.searchBar
      .rx
      .text
      .orEmpty
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .subscribe(onNext: { query in
        print(query)
      })
      .disposed(by: disposeBag)
    
    searchController.searchBar
      .rx
      .textDidBeginEditing
      .subscribe(with: self, onNext: { owner, _ in
        UIView.animate(withDuration: 0.3) {
          owner.tableView.snp.updateConstraints { make in
            make.top.equalTo(owner.view.snp.top).offset(120)
          }
          
          owner.view.layoutIfNeeded()
        }
      })
      .disposed(by: disposeBag)
    
    
    searchController.searchBar
      .rx
      .textDidEndEditing
      .subscribe(with: self, onNext: { owner, _ in
        UIView.animate(withDuration: 0.3) {
          owner.tableView.snp.updateConstraints { make in
            make.top.equalTo(owner.view.snp.top).offset(156)
          }
          
          owner.view.layoutIfNeeded()
        }
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
}

@available(iOS 17.0, *)
#Preview {
  let configuartion = AppConfigurationImpl()
  let homeViewController = HomeViewController(appConfiguration: configuartion)
  let controller = UINavigationController(rootViewController: homeViewController)
  return controller
}
