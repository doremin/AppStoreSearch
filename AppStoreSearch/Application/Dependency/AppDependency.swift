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
    
    let loggerPlugin = AppStoreAPILoggerPlugin()
    let provider = MoyaProvider<AppStoreAPI>(plugins: [loggerPlugin])
    let appStoreSearchRepository = AppStoreSearchRepositoryImpl(provider: provider)
    let appStoreSearchHistoryRepository = AppStoreSearchHistoryRepositoryImpl(container: PersistentContainerImpl.shared)
    
    let homeViewModel = HomeViewModel(
      appConfiguration: appConfiguration,
      appStoreSearchHistoryRepository: appStoreSearchHistoryRepository)
    let homeViewController = HomeViewController(
      viewModel: homeViewModel,
      searchResultViewControllerFactory: { query in
        let searchResultViewModel = SearchResultViewModel(
          query: query,
          appConfiguration: appConfiguration,
          appStoreSearchRepository: appStoreSearchRepository)
        let searchResultViewController = SearchResultViewController(viewModel: searchResultViewModel)
        
        return searchResultViewController
      })
    
    let settingsViewModel = SettingsViewModel(appConfiguration: appConfiguration)
    let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
    
    let mainTabBarViewModel = MainTabBarViewModel(appConfiguration: appConfiguration)
    let mainTabBarController = MainTabBarController(
      viewModel: mainTabBarViewModel,
      viewControllers: homeViewController,
      settingsViewController)
    
    _ = appConfiguration.isDarkMode
      .map { isDarkMode -> UIUserInterfaceStyle in
        return isDarkMode ? .dark : .light
      }
      .bind(to: window.rx.overrideUserInterfaceStyle)
    
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
