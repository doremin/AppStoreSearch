//
//  AppStoreAPILoggerPlugin.swift
//  AppStoreSearch
//
//  Created by doremin on 2/1/24.
//

import Foundation

import Moya

final class AppStoreAPILoggerPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    #if DEBUG
    if let requestURL = request.url?.absoluteString,
       let httpBody = request.httpMethod,
       let method = request.httpMethod
    {
      let message = """
      -----------
      HTTP Method: \(method)
      URL: \(requestURL)
      Body: \(httpBody)
      -----------
      """
      print(message)
    }
    #endif
    
    return request
  }
}
