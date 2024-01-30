//
//  SceneDelegateTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/30/24.
//

import XCTest
@testable import AppStoreSearch

final class SceneDelegateTests: XCTestCase {
  
  func test_whenInitialized_thenDependencyIsNil() {
    // when
    let sut = SceneDelegate()
    
    // then
    XCTAssertNil(sut.dependency)
  }
}
