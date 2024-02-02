//
//  SettingsViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

import RxSwift

final class SettingsViewModel: ViewModel {
  struct Input {
    let darkModeSwitchValueChanged: Observable<Bool>
  }
  
  struct Output {
    let backgroundColor: Observable<UIColor>
    let textColor: Observable<UIColor>
    let isDarkMode: Observable<Bool>
  }
  
  var disposeBag = DisposeBag()
  private let appConfiguration: AppConfiguration
  
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
  }
  
  func transform(input: Input) -> Output {
    input.darkModeSwitchValueChanged
      .bind(to: appConfiguration.isDarkMode)
      .disposed(by: disposeBag)
    
    let backgroundColor = appConfiguration.backgroundColor
    let textColor = appConfiguration.textColor
    let isDarkMode = appConfiguration.isDarkMode.asObservable()
    
    let output = Output(
      backgroundColor: backgroundColor,
      textColor: textColor,
      isDarkMode: isDarkMode)
    
    return output
  }
}
