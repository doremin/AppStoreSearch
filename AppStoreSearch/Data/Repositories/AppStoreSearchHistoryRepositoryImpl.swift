//
//  AppStoreSearchHistoryRepositoryImpl.swift
//  AppStoreSearch
//
//  Created by doremin on 2/5/24.
//

import Foundation

import RxSwift

final class AppStoreSearchHistoryRepositoryImpl {
  private let container: PersistentContainer
  
  init(container: PersistentContainer) {
    self.container = container
  }
}

extension AppStoreSearchHistoryRepositoryImpl: AppStoreSearchHistoryRepository {
  func fetchHistories(limit: Int) -> Observable<[SearchHistory]> {
    return .create { observer in
      self.container.perform { context in
        do {
          let request = AppStoreQueryEntity.fetchRequest()
          request.fetchLimit = limit
          request.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(AppStoreQueryEntity.createdAt), ascending: false)
          ]
          
          let result = try context.fetch(request).map { $0.domain }
          observer.onNext(result)
          observer.onCompleted()
        } catch {
          observer.onError(error)
        }
      }
      
      return Disposables.create()
    }
  }
  
  func saveHistory(history: SearchHistory) -> Completable {
    return .create { completable in
      self.container.perform { context in
        do {
          let _ = AppStoreQueryEntity(history: history, insertInto: context)
          
          try context.save()
          completable(.completed)
        } catch {
          completable(.error(error))
        }
      }
      
      return Disposables.create()
    }
  }
}
