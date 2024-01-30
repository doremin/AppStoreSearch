//
//  SettingsViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

final class SettingsViewController: BaseViewController {
  
  // MARK: UI
  private let stackView = UIStackView()
  
  // MARK: Properties
  private let appConfiguration: AppConfiguration
  
  // MARK: Initializer
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
    super.init()
    self.title = "Settings"
    self.tabBarItem.image = UIImage(systemName: "gearshape.2")
    self.tabBarItem.selectedImage = UIImage(systemName: "gearshape.2.fill")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 
  
  // MARK: Layout
  override func addSubviews() {
    
  }
  
  override func setupConstraints() {
    
  }
}

#Preview {
  let config = AppConfigurationImpl()
  let controller = SettingsViewController(appConfiguration: config)
  return controller
}
