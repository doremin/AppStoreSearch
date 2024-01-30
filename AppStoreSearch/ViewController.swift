//
//  ViewController.swift
//  AppStoreSearch
//
//  Created by doremin on 1/29/24.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  
  override func loadView() {
    let label = UILabel()
    label.text = "prod"
    label.textAlignment = .center
    label.textColor = .white
    view = label
  }

}

