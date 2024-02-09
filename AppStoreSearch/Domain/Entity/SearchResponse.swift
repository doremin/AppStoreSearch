//
//  SearchResponse.swift
//  AppStoreSearch
//
//  Created by doremin on 2/4/24.
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
    let artworkUrl60: String
  }
}

extension SearchResponse.SearchResult {
  static var dummy: Self {
    return .init(
      screenshotUrls: [
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/17/78/68/177868f6-193c-b520-6d8d-318efde4a61d/b527bf39-ad06-4b34-a2cc-cf5e21fd8fc0_Fitness-iPhone5p5-Vert-DawnC-USEN-Wrapper1.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/17/78/68/177868f6-193c-b520-6d8d-318efde4a61d/b527bf39-ad06-4b34-a2cc-cf5e21fd8fc0_Fitness-iPhone5p5-Vert-DawnC-USEN-Wrapper1.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/17/78/68/177868f6-193c-b520-6d8d-318efde4a61d/b527bf39-ad06-4b34-a2cc-cf5e21fd8fc0_Fitness-iPhone5p5-Vert-DawnC-USEN-Wrapper1.png/392x696bb.png",
      ],
      trackCensoredName: "피트니스",
      userRatingCount: 374,
      trackContentRating: "4+",
      formattedPrice: "무료",
      primaryGenreName: "Health & Fitness",
      description: "pple Fitness 및 Apple Fitness+\n활동 세부사항 및 기록, 추세, 배지, 가족 및 친구와 공유 등 사용자의 피트니스에 관한 종합적인 정보를 파악할 수 있습니다. Apple Fitness+를 구독하면 매주 제공되는 수천 개의 운동과 명상을 통해 활동적으로 생활하고 마음을 챙기는 시간을 가질 수 있습니다.\n\nAPPLE FITNESS \n\n요약 탭\n활동 세부사항, 운동, 마음 챙기기, 다이빙 기록, 추세 및 배지를 확인할 수 있습니다.",
      trackName: "피트니스 - 아브라카다브라 아브라카다브라 아브라카다브라",
      sellerName: "Apple Distribution International",
      averageUserRating: 3.20588000006295,
      artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c2/ae/ca/c2aecacf-fa2c-e349-4451-d0271ea4356e/AppIcon-0-0-1x_U007emarketing-0-10-0-85-220.png/60x60bb.jpg")
  }
}

extension SearchResponse {
  static var dummy: Self {
    return .init(
      resultCount: 6,
      results: [
        .dummy,
        .dummy,
        .dummy,
        .dummy,
        .dummy,
        .dummy,
      ])
  }
}
