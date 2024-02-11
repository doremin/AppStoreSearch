//
//  HomeViewModelTests.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/11/24.
//

import UIKit
import XCTest

import RxSwift
import RxTest

@testable import AppStoreSearch

final class HomeViewModelTests: XCTestCase {
  
  var sut: HomeViewModel!
  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!
  var input: HomeViewModel.Input!
  
  // ViewModel Input
  var query: PublishSubject<String>!
  var searchButtonClicked: PublishSubject<Void>!
  var textDidBeginEditing: PublishSubject<Void>!
  var textDidEndEditing: PublishSubject<Void>!
  var tableViewWillBeginDragging: PublishSubject<Void>!
  var tableViewItemDeleted: PublishSubject<IndexPath>!
  var tableViewItemSelected: PublishSubject<IndexPath>!
  var tableViewModelSelected: PublishSubject<SearchHistory>!
  var viewWillAppear: PublishSubject<Bool>!
  var viewWillDisappear: PublishSubject<Bool>!
  
  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    sut = HomeViewModel(
      appConfiguration: StubAppConfiguration(),
      appStoreSearchHistoryRepository: StubAppStoreSearchHistoryRepository())
    
    query = .init()
    searchButtonClicked = .init()
    textDidBeginEditing = .init()
    textDidEndEditing = .init()
    tableViewWillBeginDragging = .init()
    tableViewItemDeleted = .init()
    tableViewItemSelected = .init()
    tableViewModelSelected = .init()
    viewWillAppear = .init()
    viewWillDisappear = .init()
    
    input = .init(
      query: query.asObservable(),
      searchButtonClicked: searchButtonClicked.asObservable(),
      textDidBeginEditing: textDidBeginEditing.asObservable(),
      textDidEndEditing: textDidEndEditing.asObservable(),
      tableViewWillBeginDragging: tableViewWillBeginDragging.asObservable(),
      tableViewItemDeleted: tableViewItemDeleted.asObservable(),
      tableViewItemSelected: tableViewItemSelected.asObservable(),
      tableViewModelSelected: tableViewModelSelected.asObservable(),
      viewWillAppear: viewWillAppear.asObservable(),
      viewWillDisappear: viewWillDisappear.asObservable())
  }
  
  func test_whenSearchButtonClicked_thenQueryDelivered() {
    // given
    let observer = scheduler.createObserver(String.self)
    
    let output = sut.transform(input: input)
    
    output.queryWhenSearchButtonClicked
      .subscribe(observer)
      .disposed(by: disposeBag)
    
    let buttonEvents: [Recorded<Event<Void>>] = [
      .next(1, ()),
      .next(4, ()),
      .next(8, ())
    ]
    
    let queryEvents: [Recorded<Event<String>>] = [
      .next(2, "query"),
      .next(4, "test"),
      .next(7, "query")
    ]
    
    // when
    scheduler.createColdObservable(queryEvents)
      .bind(to: query)
      .disposed(by: disposeBag)
    
    scheduler.createColdObservable(buttonEvents)
      .bind(to: searchButtonClicked)
      .disposed(by: disposeBag)
    
    scheduler.start()
    
    // then
    let expected: [Recorded<Event<String>>] = [
      .next(4, "test"),
      .next(8, "query")
    ]
    
    XCTAssertEqual(observer.events, expected)
  }
}
