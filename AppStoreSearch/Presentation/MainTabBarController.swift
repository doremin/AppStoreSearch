//
//  MainTabBarController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
  
  init(_ viewControllers: BaseViewController...)
  {
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = viewControllers
      .map {
        let navigationController = UINavigationController(rootViewController: $0)
        return navigationController
      }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
