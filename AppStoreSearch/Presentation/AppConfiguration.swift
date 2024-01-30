//
//  AppConfiguration.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

import RxCocoa
import RxSwift

protocol AppConfiguration {
  var isDarkMode: BehaviorRelay<Bool> { get }
  var textColor: Observable<UIColor> { get }
  var backgroundColor: Observable<UIColor> { get }
}

final class AppConfigurationImpl: AppConfiguration {
  
  // MARK: UserDefaults Keys
  enum UserDefaultsKeys: String {
    case isDarkMode = "IsDarkMode"
  }
  
  // MARK: Properties
  let isDarkMode: BehaviorRelay<Bool> = {
    let value = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isDarkMode.rawValue)
    return BehaviorRelay(value: value)
  }()
  
  let textColor: Observable<UIColor>
  let backgroundColor: Observable<UIColor>
  
  // MARK: Dispose Bag
  private var disposeBag = DisposeBag()
  
  init() {
    textColor = isDarkMode
      .map { $0 ? UIColor.white : .black }
    
    backgroundColor = isDarkMode
      .map { $0 ? UIColor.black : .white}
    
    isDarkMode
      .subscribe(onNext: { value in
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.isDarkMode.rawValue)
      })
      .disposed(by: disposeBag)
  }
}
