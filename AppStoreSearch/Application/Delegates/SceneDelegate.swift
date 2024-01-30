//
//  SceneDelegate.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var dependency: AppDependency?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions)
  {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    dependency = dependency ?? .resolve(windowScene: windowScene)
    window = dependency?.window
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    dependency?.openURLHandler(scene, URLContexts)
  }
}
