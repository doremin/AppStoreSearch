//
//  BaseViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/30/24.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
  
  // MARK: Properties
  private var className: String {
    return type(of: self).description().components(separatedBy: ".").last ?? ""
  }
  
  // MARK: Rx
  var disposeBag = DisposeBag()
  
  // MARK: Initializing
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Deinit
  deinit {
    // TODO: Add Log
  }
  
  // MARK: Layout Constraints
  private(set) var didSetupConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      addSubviews()
      setupConstraints()
      didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
  
  func addSubviews() {
    // Overrride point
  }
  
  func setupConstraints() {
    // Override point
  }
}
