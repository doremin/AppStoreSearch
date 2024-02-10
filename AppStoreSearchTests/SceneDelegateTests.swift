//
//  SceneDelegateTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/30/24.
//

import XCTest
@testable import AppStoreSearch

final class SceneDelegateTests: XCTestCase {
  
  var sut: SceneDelegate!

  override func setUp() {
    super.setUp()
    sut = SceneDelegate()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_whenInitialized_thenDependencyIsNil() {
    // then
    XCTAssertNil(sut.dependency)
  }
}
