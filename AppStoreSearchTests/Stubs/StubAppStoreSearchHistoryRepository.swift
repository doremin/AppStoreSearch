//
//  StubAppStoreSearchHistoryRepository.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/11/24.
//

import RxSwift

@testable import AppStoreSearch

final class StubAppStoreSearchHistoryRepository: AppStoreSearchHistoryRepository {
  func fetchHistories(limit: Int) -> Observable<[SearchHistory]> {
    let dummyHistory = SearchHistory(query: "deliver")
    
    return .just([
      dummyHistory,
      dummyHistory,
      dummyHistory,
      dummyHistory,
    ])
  }
  
  func saveHistory(history: SearchHistory) -> Completable {
    return .empty()
  }
}
