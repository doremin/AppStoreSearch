//
//  StubAppConfiguration.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/11/24.
//

import XCTest

import RxCocoa
import RxSwift

@testable import AppStoreSearch

final class StubAppConfiguration: AppConfiguration {
  let isDarkMode: BehaviorRelay<Bool>
  let textColor: Observable<UIColor>
  let backgroundColor: Observable<UIColor>
  let displayScale: Observable<CGFloat>
  
  init(
    isDarkMode: Bool = true,
    textColor: UIColor = .white,
    backgroundColor: UIColor = .black,
    displayScale: CGFloat = 3.0)
  {
    self.isDarkMode = BehaviorRelay(value: isDarkMode)
    self.textColor = .just(textColor)
    self.backgroundColor = .just(backgroundColor)
    self.displayScale = .just(displayScale)
  }
}
