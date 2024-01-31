//
//  AppStoreSearchRepository.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import Foundation

protocol AppStoreSearchRepository {
  func search(query: String, limit: Int) -> SearchResponse
}
