//
//  AppStoreSearchRepository.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import Moya
import RxSwift

protocol AppStoreSearchRepository {
  func search(query: String, limit: Int, media: String, country: String) -> Single<SearchResponse>
}
