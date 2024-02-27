//
//  SearchHistoryTableViewCellTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/27/24.
//

import XCTest

@testable import AppStoreSearch

final class SearchHistoryTableViewCellTests: XCTestCase {
  
  var sut: SearchHistoryTableViewCell!
  
  override func setUp() {
    super.setUp()
    
    sut = SearchHistoryTableViewCell()
  }
  
  func test_whenConfigCalled_thenQueryLabelTextChanged() {
    // given
    let text = "TEST"
    
    // when
    sut.config(text: text)
    
    // then
    XCTAssertEqual(text, sut.queryLabel.text!)
  }
}
