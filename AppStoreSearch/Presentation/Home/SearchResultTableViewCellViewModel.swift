//
//  SearchResultTableViewCellViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 2/6/24.
//

import Foundation
import UIKit

import RxSwift

final class SearchResultTableViewCellViewModel: ViewModel {
  
  // MARK: Input
  struct Input { }
  
  // MARK: Output
  struct Output {
    let textColor: Observable<UIColor>
    let searchResult: Observable<SearchResponse.SearchResult>
    let displayScale: Observable<CGFloat>
  }
  
  // MARK: Dispose Bag
  var disposeBag = DisposeBag()
  
  // MARK: Properties
  private let appConfiguration: AppConfiguration
  private let searchResult: SearchResponse.SearchResult
  
  init(
    appConfiguration: AppConfiguration,
    searchResult: SearchResponse.SearchResult)
  {
    self.appConfiguration = appConfiguration
    self.searchResult = searchResult
  }
  
  
  // MARK: Transform Input -> Output
  func transform(input: Input) -> Output {
    return Output(
      textColor: appConfiguration.textColor,
      searchResult: .just(searchResult),
      displayScale: appConfiguration.displayScale)
  }
}
