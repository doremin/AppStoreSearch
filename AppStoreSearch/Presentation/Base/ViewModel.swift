//
//  ViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 1/31/24.
//

import RxSwift

protocol ViewModel {
  associatedtype Input
  associatedtype Output
  func transform(input: Input) -> Output
  
  var disposeBag: DisposeBag { get set }
}
