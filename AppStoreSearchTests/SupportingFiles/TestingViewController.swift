//
//  TestingRootViewController.swift
//  AppStoreSearchTests
//
//  Created by doremin on 1/29/24.
//

import UIKit

final class TestingViewController: UIViewController {
  lazy var testingLabel: UILabel = {
    let label = UILabel()
    label.text = "Running Unit Tests ..."
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  override func loadView() {
    view = testingLabel
  }
}
