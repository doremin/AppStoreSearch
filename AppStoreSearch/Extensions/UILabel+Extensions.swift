//
//  UILabel+Extensions.swift
//  AppStoreSearch
//
//  Created by doremin on 2/2/24.
//

import UIKit

extension UILabel {
  enum Style {
    case bold
    case normal
    case italic
  }
  
  static func make(
    _ text: String,
    style: Style = .normal,
    size: CGFloat,
    color: UIColor = .black)
    -> UILabel
  {
    let label = UILabel()
    label.text = text
    label.textColor = color
    
    switch style {
    case .bold:
      label.font = .boldSystemFont(ofSize: size)
    case .italic:
      label.font = .italicSystemFont(ofSize: size)
    case .normal:
      label.font = .systemFont(ofSize: size)
    }
    
    return label
  }
}
