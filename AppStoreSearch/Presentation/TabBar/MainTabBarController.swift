//
//  MainTabBarController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

import RxCocoa
import RxSwift

final class MainTabBarController: UITabBarController {
  
  // MARK: Properties
  private let viewModel: MainTabBarViewModel
  var disposeBag = DisposeBag()
  
  // MARK: Initializer
  init(
    viewModel: MainTabBarViewModel,
    viewControllers: BaseViewController...) 
  {
    self.viewModel = viewModel
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
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.bind()
  }
  
  // MARK: Bind ViewModel
  func bind() {
    let input = MainTabBarViewModel.Input()
    let output = viewModel.transform(input: input)
    
    
  }
}
