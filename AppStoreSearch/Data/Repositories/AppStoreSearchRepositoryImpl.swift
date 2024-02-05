//
//  AppStoreSearchRepositoryImpl.swift
//  AppStoreSearch
//
//  Created by doremin on 2/4/24.
//

import Foundation

import Alamofire
import Moya
import RxMoya
import RxSwift

final class AppStoreSearchRepositoryImpl: AppStoreSearchRepository {
  
  private let provider: MoyaProvider<AppStoreAPI>
  
  init(provider: MoyaProvider<AppStoreAPI>) {
    self.provider = provider
  }
  
  func search(
    query: String,
    limit: Int,
    media: String,
    country: String)
  -> Single<SearchResponse>
  {
    let searchRequest: AppStoreAPI = .search(query: query, media: media, limit: limit, country: country)

    return provider
      .rx
      .request(searchRequest)
      .flatMap { response -> Single<SearchResponse> in
        return .create { single in
          do {
            let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: response.data)
            single(.success(searchResponse))
          } catch(let error) {
            single(.failure(error))
          }
          
          return Disposables.create()
        }
      }
  }
}
