//
//  HomeViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import UIKit

import RxCocoa
import RxSwift

final class HomeViewModel: ViewModel {
  
  // MARK: Input, Output
  struct Input {
    let query: Observable<String>
    let textDidBeginEditing: Observable<Void>
    let textDidEndEditing: Observable<Void>
  }
  
  struct Output {
    let tableViewTopOffset: PublishSubject<CGFloat>
    let backgroundColor: Observable<UIColor>
  }
  
  // MARK: Properties
  private let appConfiguration: AppConfiguration
  
  // MARK: Dispose Bag
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
  }
  
  // MARK: Transform Input -> Output
  func transform(input: Input) -> Output {
    let tableViewTopOffSet = PublishSubject<CGFloat>()
    
    
    input.textDidBeginEditing
      .map { CGFloat(120) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    input.textDidEndEditing
      .map { CGFloat(156) }
      .bind(to: tableViewTopOffSet)
      .disposed(by: disposeBag)
    
    return Output(
      tableViewTopOffset: tableViewTopOffSet,
      backgroundColor: appConfiguration.backgroundColor)
  }
}
