//
//  AppConfigurationTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/10/24.
//

import XCTest
import RxSwift
import RxTest

@testable import AppStoreSearch

final class AppConfigurationTests: XCTestCase {
  
  var sut: AppConfiguration!
  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!
  
  override func setUp() {
    super.setUp()
    sut = AppConfigurationImpl()
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
  }
  
  override func tearDown() {
    sut = nil
    scheduler = nil
    disposeBag = nil
    super.tearDown()
  }
  
  func test_whenChangeDarkMode_thenTextColorChanged() {
    // given
    let observer = scheduler.createObserver(UIColor.self)
    
    sut.textColor
      .skip(1)
      .subscribe(observer)
      .disposed(by: disposeBag)
    
    let testEvents: [Recorded<Event<Bool>>] = [
      .next(1, true),
      .next(2, false),
      .next(3, true),
    ]
    
    // when
    scheduler.createColdObservable(testEvents)
      .bind(to: sut.isDarkMode)
      .disposed(by: disposeBag)
    
    scheduler.start()
    
    // then
    let expectedEvents: [Recorded<Event<UIColor>>] = [
      .next(1, .white),
      .next(2, .black),
      .next(3, .white),
    ]
    
    XCTAssertEqual(observer.events, expectedEvents)
  }
}
