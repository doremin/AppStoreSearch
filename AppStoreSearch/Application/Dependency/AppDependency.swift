//
//  AppDependency.swift
//  AppStoreSearch
//
//  Created by doremin on 1/29/24.
//

import UIKit

import Kingfisher
import Moya
import RxCocoa
import RxSwift
import SnapKit

struct AppDependency {
  typealias OpenURLHandler = (_ scene: UIScene, _ URLContexts: Set<UIOpenURLContext>) -> Void
  
  let window: UIWindow
  let persistentContainer: PersistentContainer
  let openURLHandler: OpenURLHandler
}

extension AppDependency {
  static func resolve(windowScene: UIWindowScene) -> AppDependency {
    let window = UIWindow(windowScene: windowScene)
    let persistentContainer = PersistentContainerImpl.shared
    let appConfiguration = AppConfigurationImpl()
    let homeViewController = HomeViewController(appConfiguration: appConfiguration)
    let settingsViewController = SettingsViewController(appConfiguration: appConfiguration)
    let mainTabBarController = MainTabBarController(
      homeViewController,
      settingsViewController)
    
    window.rootViewController = mainTabBarController
    window.makeKeyAndVisible()    
    
    return AppDependency(
      window: window,
      persistentContainer: persistentContainer,
      openURLHandler: openURLFactory() )
  }
  
  static func openURLFactory() -> AppDependency.OpenURLHandler {
    return { scene, contexts in
      guard let url = contexts.first?.url else { return }
      // TODO: Add actions for open url
      print(url)
    }
  }
}
