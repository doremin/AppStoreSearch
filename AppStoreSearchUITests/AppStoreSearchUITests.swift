//
//  AppStoreSearchUITests.swift
//  AppStoreSearchUITests
//
//  Created by doremin on 2/12/24.
//

import XCTest

final class AppStoreSearchUITests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
  
  func test_whenSearchBaemin_thenExistBaemin() {
    let searchQuery = "배달의민족"
    let searchTextField = app.searchFields[AccessibilityID.homeSearchField]
    
    XCTAssertTrue(searchTextField.exists)
    
    searchTextField.tap()
    searchTextField.typeText(searchQuery)
    
    let searchButton = app.buttons["Search"]
    
    XCTAssertTrue(searchButton.exists)
    
    searchButton.tap()
    
    let baemin = app.tables.cells.containing(.staticText, identifier: "배달의민족")
    
    // 배달의민족이 첫번째 검색 결과로 안나올 때 실패
    if !baemin.element.waitForExistence(timeout: 3) {
      XCTFail("배달의 민족 없음")
    }
    
    // 배달의민족의 카테고리가 Food & Drink면 성공
    XCTAssertTrue(baemin.staticTexts["Food & Drink"].exists)
  }
}
