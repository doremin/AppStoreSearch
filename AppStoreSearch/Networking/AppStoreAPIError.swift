//
//  AppStoreAPIError.swift
//  AppStoreSearch
//
//  Created by doremin on 2/1/24.
//

import Moya

enum AppStoreAPIError: Error {
  case timeout
  case connection
}
