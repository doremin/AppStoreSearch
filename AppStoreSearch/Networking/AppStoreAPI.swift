//
//  AppStoreAPI.swift
//  AppStoreSearch
//
//  Created by doremin on 2/1/24.
//

import Foundation

import Moya

enum AppStoreAPI {
  case search(query: String, media: String, limit: Int, country: String)
}

extension AppStoreAPI: TargetType {
  var baseURL: URL {
    guard
      let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String,
      let baseURL = URL(string: baseURLString)
    else {
      fatalError("BaseURL in plist is empty")
    }
    
    return baseURL
  }
  
  var path: String {
    switch self {
    case .search:
      return "/search"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .search:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .search(query, media, limit, country):
      let parameters: [String: Any] = [
        "term": query,
        "media": media,
        "limit": limit,
        "country": country
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}
