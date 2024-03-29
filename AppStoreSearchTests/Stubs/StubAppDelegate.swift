//
//  StubAppDelegate.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/29/24.
//

import UIKit

@objc(StubAppDelegate)
final class StubAppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)
  -> Bool
  {
    for sceneSession in application.openSessions {
      application.perform(Selector(("_removeSessionFromSessionSet:")), with: sceneSession)
    }
    return true
  }
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions)
  -> UISceneConfiguration {
    let sceneConfiguration = UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role)
    sceneConfiguration.delegateClass = StubSceneDelegate.self
    
    return sceneConfiguration
  }
}
