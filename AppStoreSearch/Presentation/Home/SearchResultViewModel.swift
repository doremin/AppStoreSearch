//
//  SearchResultViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

import RxSwift

final class SearchResultViewModel: ViewModel {
  
  struct Input { }
  struct Output { }
  
  private let query: String
  private let appConfiguration: AppConfiguration
  private let appStoreSearchRepository: AppStoreSearchRepository
  
  var disposeBag = DisposeBag()
  
  init(
    query: String,
    appConfiguration: AppConfiguration,
    appStoreSearchRepository: AppStoreSearchRepository)
  {
    self.query = query
    self.appConfiguration = appConfiguration
    self.appStoreSearchRepository = appStoreSearchRepository
  }
  
  func transform(input: Input) -> Output {
    
    return .init()
  }
}
