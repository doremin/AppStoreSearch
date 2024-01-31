//
//  MainTabBarViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import UIKit

import RxSwift

final class MainTabBarViewModel: ViewModel {
  
  // MARK: Input
  struct Input {
    
  }
  
  // MARK: Output
  struct Output {
    let style: Observable<UIBarStyle>
    
  }
  
  // MARK: State
  private let appConfiguration: AppConfiguration
  
  // MARK: DisposeBag
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
  }
  
  // MARK: Transform Input -> Output
  func transform(input: Input) -> Output {
    let style = appConfiguration
      .isDarkMode
      .map { $0 ? UIBarStyle.black : .default }
    
    return .init(style: style)
  }
}
