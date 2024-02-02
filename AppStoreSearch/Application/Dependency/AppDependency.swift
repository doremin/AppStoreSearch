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
    
    let homeViewModel = HomeViewModel(appConfiguration: appConfiguration)
    let homeViewController = HomeViewController(viewModel: homeViewModel)
    
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
