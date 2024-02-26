//
//  SearchResultViewControllerTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/26/24.
//

import XCTest

@testable import AppStoreSearch

final class SearchResultViewControllerTests: XCTestCase {
  
  var sut: SearchResultViewController!
  var viewModel: SearchResultViewModel!
  
  override func setUp() {
    super.setUp()
    let appConfiguration = StubAppConfiguration()
    
    sut = SearchResultViewController(
      viewModel: SearchResultViewModel(
        query: "TEST",
        appConfiguration: appConfiguration,
        appStoreSearchRepository: StubAppStoreSearchRepository()),
      cellViewModelFacotry: { result in
        return SearchResultTableViewCellViewModel(appConfiguration: appConfiguration, searchResult: .dummy)
      })
  }
  
  func test_whenViewDidLoaded_thenSubviewsAdded() {
    // when (make view did load called)
    _ = sut.view
    
    // then
    let expected = """
    \(UIView.typeString)
    --\(UITableView.typeString)
    --\(UIActivityIndicatorView.typeString)
    ----\(UIImageView.typeString)
    """
    
    XCTAssertEqual(expected, sut.view.subviewsSnapshot)
  }
}
