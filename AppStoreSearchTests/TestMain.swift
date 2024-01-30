//
//  TestMain.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/30/24.
//

import XCTest

final class TestMain: XCTestCase {
  func test_whenLaunched_thenAppDelegateIsTestAppDelegate() {
    XCTAssertTrue(UIApplication.shared.delegate is StubAppDelegate)
  }
}
