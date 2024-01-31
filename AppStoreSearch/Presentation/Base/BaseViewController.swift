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
  
  // MARK: Initializer
  init() {
    super.init(nibName: nil, bundle: nil)
    // TODO: Add Log
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Deinit
  deinit {
    // TODO: Add Log
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    addSubviews()
    setupConstraints()
    bind()
  }
  
  func bind() {
    // Override point
  }
  
  func addSubviews() {
    // Overrride point
  }
  
  func setupConstraints() {
    // Override point
  }
}
