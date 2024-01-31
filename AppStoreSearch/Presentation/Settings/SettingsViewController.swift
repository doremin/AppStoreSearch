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
  private let darkModeSwitch = UISwitch()
  
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
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    appConfiguration
      .backgroundColor
      .bind(to: view.rx.backgroundColor)
      .disposed(by: disposeBag)
    
    appConfiguration.isDarkMode
      .bind(to: darkModeSwitch.rx.isOn)
      .disposed(by: disposeBag)
    
    darkModeSwitch
      .rx
      .value
      .changed
      .distinctUntilChanged()
      .bind(to: appConfiguration.isDarkMode)
      .disposed(by: disposeBag)
  }
  
  // MARK: Layout
  override func addSubviews() {
    view.add {
      stackView.add {
        darkModeSwitch
      }
    }
  }
  
  override func setupConstraints() {
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    darkModeSwitch.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalToSuperview().offset(30)
    }
  }
}

#Preview {
  let config = AppConfigurationImpl()
  let controller = SettingsViewController(appConfiguration: config)
  return controller
}
