//
//  SearchResultViewModel.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

import Moya
import RxCocoa
import RxSwift

final class SearchResultViewModel: ViewModel {
  
  struct Input {
    let viewDidAppear: Observable<Bool>
  }
  struct Output { 
    let backgroundColor: Observable<UIColor>
    let searchResponses: Observable<[SearchResultSection]>
    let isLoadingIndicatorActive: Observable<Bool>
    let error: Observable<Error>
  }
  
  private let query: String
  private let appConfiguration: AppConfiguration
  private let appStoreSearchRepository: AppStoreSearchRepository
  
  var disposeBag = DisposeBag()
  
  init(
    query: String,
    appConfiguration: AppConfiguration,
    appStoreSearchRepository: AppStoreSearchRepository)
  {
    self.query = query
    self.appConfiguration = appConfiguration
    self.appStoreSearchRepository = appStoreSearchRepository
  }
  
  func transform(input: Input) -> Output {
    
    let searchResultSections = PublishRelay<[SearchResultSection]>()
    let isLoadingIndicatorActive = PublishRelay<Bool>()
    let errorSubject = PublishSubject<Error>()
    
    input.viewDidAppear
      .take(1)
      .withUnretained(self)
      .flatMap { owner, _ -> Single<SearchResponse> in
        isLoadingIndicatorActive.accept(true)
        return owner.appStoreSearchRepository.search(query: owner.query, limit: 20, media: "software", country: "KR")
          .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
          .retry(2)
      }
      .subscribe(
        onNext: { searchResponse in
          let section = SearchResultSection(items: searchResponse.results)
          searchResultSections.accept([section])
        },
        onError: { error in
          errorSubject.onNext(error)
        },
        onCompleted: {
          isLoadingIndicatorActive.accept(false)
        })
      .disposed(by: disposeBag)
      
    return .init(
      backgroundColor: appConfiguration.backgroundColor,
      searchResponses: searchResultSections.asObservable(),
      isLoadingIndicatorActive: isLoadingIndicatorActive.asObservable(),
      error: errorSubject.asObservable())
  }
}
