//
//  HomeViewControllerTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/11/24.
//

import XCTest

@testable import AppStoreSearch

final class HomeViewControllerTests: XCTestCase {
  
  var sut: HomeViewController!
  var viewModel: HomeViewModel!
  
  override func setUp() {
    super.setUp()
    
    sut = HomeViewController(
      viewModel: HomeViewModel(
        appConfiguration: StubAppConfiguration(),
        appStoreSearchHistoryRepository: StubAppStoreSearchHistoryRepository()),
      searchResultViewControllerFactory: nil)
  }
  
  func test_whenViewDidLoaded_thenSubviewsAdded() {
    // given
    let expected = """
    \(UIView.typeString)
    --\(UITableView.typeString)
    """
    
    // when
    // make viewDidLoad() called
    _ = sut.view

    // then
    XCTAssertEqual(expected, sut.view.subviewsSnapshot)
  }
  
  
}
