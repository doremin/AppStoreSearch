//
//  AppStoreSearchHistoryRepository.swift
//  AppStoreSearch
//
//  Created by doremin on 2/5/24.
//

import Foundation

import RxSwift

protocol AppStoreSearchHistoryRepository {
  func fetchHistories(limit: Int) -> Observable<[SearchHistory]>
  func saveHistory(history: SearchHistory) -> Completable
}
