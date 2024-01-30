//
//  StubSceneDelegate.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/30/24.
//

import UIKit

final class StubSceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions)
  {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = TestingViewController()
    window?.makeKeyAndVisible()
  }
}
