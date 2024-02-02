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
  
  // MARK: Input, Output
  struct Input {
    let textDidBeginEditing: Observable<Void>
    let textDidEndEditing: Observable<Void>
    let tableViewWillBeginDragging: Observable<Void>
  }
  
  struct Output {
    let tableViewTopOffset: PublishSubject<CGFloat>
    let backgroundColor: Observable<UIColor>
    let searchHistories: Observable<[SearchHistorySection]>
    let searchControllerIsActive: Observable<Bool>
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
    
    let searchHistories = SearchHistorySection(
      items: [
        SearchHistory(query: "aa"),
        SearchHistory(query: "bb")
      ])
    
    input.textDidBeginEditing
      .map { CGFloat(120) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    input.textDidEndEditing
      .map { CGFloat(156) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    let searchControllerIsActive = input.tableViewWillBeginDragging
      .map { false }
    
    return Output(
      tableViewTopOffset: tableViewTopOffSet,
      backgroundColor: appConfiguration.backgroundColor,
      searchHistories: Observable.of([searchHistories]),
      searchControllerIsActive: searchControllerIsActive)
  }
}
