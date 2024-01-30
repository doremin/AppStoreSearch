//
//  AppDependency.swift
//  AppStoreSearch
//
//  Created by doremin on 1/29/24.
//

import UIKit

struct AppDependency {
  typealias OpenURLHandler = (_ scene: UIScene, _ URLContextx: Set<UIOpenURLContext>) -> Void
  
  let window: UIWindow
  let persistentContainer: PersistentContainer
  let openURLHandler: OpenURLHandler
}

extension AppDependency {
  static func resolve(windowScene: UIWindowScene) -> AppDependency {
    let window = UIWindow(windowScene: windowScene)
    let persistentContainer = PersistentContainerImpl()
    
    return AppDependency(
      window: window,
      persistentContainer: persistentContainer,
      openURLHandler: { _, _ in } )
  }
}
