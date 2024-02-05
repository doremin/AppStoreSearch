//
//  HomeViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

final class HomeViewModel: ViewModel {
  
  typealias ModelInfo = (IndexPath, SearchHistory)
  
  // MARK: Input, Output
  struct Input {
    let query: Observable<String>
    let searchButtonClicked: Observable<Void>
    let textDidBeginEditing: Observable<Void>
    let textDidEndEditing: Observable<Void>
    let tableViewWillBeginDragging: Observable<Void>
    let tableViewItemDeleted: Observable<IndexPath>
    let tableViewItemSelected: Observable<IndexPath>
    let tableViewModelSelected: Observable<SearchHistory>
  }
  
  struct Output {
    let tableViewTopOffset: PublishSubject<CGFloat>
    let backgroundColor: Observable<UIColor>
    let searchHistories: Observable<[SearchHistorySection]>
    let searchControllerIsActive: Observable<Bool>
    let selectedModel: Observable<ModelInfo>
    let queryWhenSearchButtonClicked: Observable<String>
  }
  
  // MARK: Properties
  private let appConfiguration: AppConfiguration
  
  // MARK: Dispose Bag
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
  }
  
  // MARK: Transform Input -> Output
  func transform(input: Input) -> Output {
    let tableViewTopOffSet = PublishSubject<CGFloat>()
    
    // Todo: Replace Search Histories Dummy
    let searchHistories = BehaviorRelay(value: [SearchHistorySection(
      items: [
        SearchHistory(query: "aa"),
        SearchHistory(query: "bb")
      ])
    ])
    
    input.textDidBeginEditing
      .map { CGFloat(120) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    input.textDidEndEditing
      .map { CGFloat(156) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
      
    Observable.zip(searchHistories, input.tableViewItemDeleted)
      .sample(input.tableViewItemDeleted)
      .subscribe(onNext: { section, indexPath in
        var currentSection = section[indexPath.section]
        currentSection.items.remove(at: indexPath.row)
        searchHistories.accept([currentSection])
      })
      .disposed(by: disposeBag)
    
    let searchControllerIsActive = Observable.merge(
      input.tableViewItemSelected.map { _ in },
      input.tableViewWillBeginDragging,
      input.searchButtonClicked)
      .delay(.milliseconds(100), scheduler: MainScheduler.instance)
      .map { _ in false }
    
    let selectedModel = Observable.zip(input.tableViewItemSelected, input.tableViewModelSelected)
    
    let queryWhenSearchButtonClicked = input.query
      .sample(input.searchButtonClicked)
    
    return Output(
      tableViewTopOffset: tableViewTopOffSet,
      backgroundColor: appConfiguration.backgroundColor,
      searchHistories: searchHistories.asObservable(),
      searchControllerIsActive: searchControllerIsActive,
      selectedModel: selectedModel,
      queryWhenSearchButtonClicked: queryWhenSearchButtonClicked)
  }
}
