//
//  AppStoreSearchRepositoryImpl.swift
//  AppStoreSearch
//
//  Created by doremin on 2/4/24.
//

import Foundation

import Moya

final class AppStoreSearchRepositoryImpl: AppStoreSearchRepository {
  
  private let provider: MoyaProvider<AppStoreAPI>
  
  init(provider: MoyaProvider<AppStoreAPI>) {
    self.provider = provider
  }
  
  func search(query: String, limit: Int) -> SearchResponse {
    return .dummy
  }
}
