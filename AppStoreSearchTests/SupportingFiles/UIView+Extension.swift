//
//  UIView+Extension.swift
//  AppStoreSearchTests
//
//  Created by doremin on 2/11/24.
//

import UIKit

/// subviewsSnapshot을 호출하면 DFS로 subview들을 탐색하여 String으로 반환합니다.
/// View의 subview들이 원하는 대로 구성되어 있는지 확인하기 위해서 사용합니다.
extension UIView {
  var subviewsSnapshot: String {
    var result = search(self, level: 0)
    result.removeLast()
    return result
  }
  
  static var typeString: String {
    return String(describing: Self.self)
  }
  
  private func search(_ view: UIView, level: Int) -> String {
    guard !view.subviews.isEmpty else {
      return String(repeating: "--", count: level) + String(describing: type(of: view)) + "\n"
    }
    
    var result = String(repeating: "--", count: level) + String(describing: type(of: view))
    result += "\n"
    result += view.subviews.map { search($0, level: level + 1) }.joined()
    
    return result
  }
}
