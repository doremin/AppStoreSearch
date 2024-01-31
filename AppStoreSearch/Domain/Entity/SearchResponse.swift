//
//  SearchResponse.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import Foundation

struct SearchResponse: Decodable {
  let resultCount: Int
  let results: [SearchResult]
}

extension SearchResponse {
  struct SearchResult: Decodable {
    let screenshotUrls: [String]
    let trackCensoredName: String
    let userRatingCount: Int
    let trackContentRating: String
    let formattedPrice: String
    let primaryGenreName: String
    let description: String
    let trackName: String
    let sellerName: String
    let averageUserRating: Double
  }
}
