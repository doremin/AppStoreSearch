//
//  StubAppStoreSearchRepository.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/13/24.
//

import RxSwift

@testable import AppStoreSearch

final class StubAppStoreSearchRepository: AppStoreSearchRepository {
  func search(
    query: String,
    limit: Int,
    media: String,
    country: String) 
  -> Single<SearchResponse>
  {
    return .just(.dummy)
  }
}
