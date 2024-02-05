//
//  SearchResultSection.swift
//  AppStoreSearch
//
//  Created by doremin on 2/4/24.
//

import RxDataSources

struct SearchResultSection {
  var items: [SearchResponse.SearchResult]
}

extension SearchResultSection: SectionModelType {
  init(original: SearchResultSection, items: [SearchResponse.SearchResult]) {
    self = original
    self.items = items
  }
}
