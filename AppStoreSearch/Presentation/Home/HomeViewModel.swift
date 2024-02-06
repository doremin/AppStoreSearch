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
    let viewWillAppear: Observable<Bool>
    let viewWillDisappear: Observable<Bool>
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
  private let appStoreSearchHistoryRepository: AppStoreSearchHistoryRepository
  
  // MARK: Dispose Bag
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  init(
    appConfiguration: AppConfiguration,
    appStoreSearchHistoryRepository: AppStoreSearchHistoryRepository)
  {
    self.appConfiguration = appConfiguration
    self.appStoreSearchHistoryRepository = appStoreSearchHistoryRepository
  }
  
  // MARK: Transform Input -> Output
  func transform(input: Input) -> Output {
    let tableViewTopOffSet = PublishSubject<CGFloat>()
    
    let searchHistories = input.viewWillAppear
      .withUnretained(self)
      .flatMap { owner, _ in
        return owner.appStoreSearchHistoryRepository.fetchHistories(limit: 20)
          .map { [SearchHistorySection(items: $0)] }
      }
    
    input.textDidBeginEditing
      .map { CGFloat(120) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    input.textDidEndEditing
      .map { CGFloat(156) }
      .bind(to: tableViewTopOffSet)
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
    
    queryWhenSearchButtonClicked
      .withUnretained(self)
      .flatMap { owner, query in
        let history = SearchHistory(query: query)
        
        return owner.appStoreSearchHistoryRepository.saveHistory(history: history)
      }
      .subscribe()
      .disposed(by: disposeBag)
    
    return Output(
      tableViewTopOffset: tableViewTopOffSet,
      backgroundColor: appConfiguration.backgroundColor,
      searchHistories: searchHistories.asObservable(),
      searchControllerIsActive: searchControllerIsActive,
      selectedModel: selectedModel,
      queryWhenSearchButtonClicked: queryWhenSearchButtonClicked)
  }
}
