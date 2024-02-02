//
//  SearchHistorySection.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import RxDataSources

struct SearchHistorySection {
  var items: [SearchHistory]
}

extension SearchHistorySection: SectionModelType {
  
  init(original: SearchHistorySection, items: [SearchHistory]) {
    self = original
    self.items = items
  }
}
