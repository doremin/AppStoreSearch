//
//  SettingsViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

final class SettingsViewController: BaseViewController {
  
  // MARK: UI
  private let darkModeSwitchContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  private let darkModeLabel: UILabel = {
    return .make(
      "Dark Mode",
      size: 16)
  }()
  
  private let darkModeSwitch = UISwitch()
  
  // MARK: Properties
  private let viewModel: SettingsViewModel
  
  // MARK: Initializer
  init(viewModel: SettingsViewModel) {
    self.viewModel = viewModel
    super.init()
    self.title = "Settings"
    self.tabBarItem.image = UIImage(systemName: "gearshape.2")
    self.tabBarItem.selectedImage = UIImage(systemName: "gearshape.2.fill")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Bind
  override func bind() {
    let darkModeSwitchValueChanged = darkModeSwitch
      .rx
      .value
      .changed
      .distinctUntilChanged()
      .asObservable()
    
    let input = SettingsViewModel.Input(darkModeSwitchValueChanged: darkModeSwitchValueChanged)
    
    let output = viewModel.transform(input: input)
    output.backgroundColor
      .bind(to: view.rx.backgroundColor)
      .disposed(by: disposeBag)
    
    output.textColor
      .bind(to: darkModeLabel.rx.textColor)
      .disposed(by: disposeBag)
    
    output.isDarkMode
      .bind(to: darkModeSwitch.rx.isOn)
      .disposed(by: disposeBag)
  }
  
  // MARK: Layout
  override func addSubviews() {
    view.add {
      darkModeSwitchContainer.add {
        darkModeLabel
        darkModeSwitch
      }
    }
  }
  
  override func setupConstraints() {
    darkModeSwitchContainer.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(75)
    }
    
    darkModeLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.equalToSuperview().offset(30)
    }
    
    darkModeSwitch.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.right.equalToSuperview().inset(30)
    }
  }
}

@available(iOS 17.0, *)
#Preview {
  let config = AppConfigurationImpl()
  let viewModel = SettingsViewModel(appConfiguration: config)
  let controller = SettingsViewController(viewModel: viewModel)
  return controller
}
