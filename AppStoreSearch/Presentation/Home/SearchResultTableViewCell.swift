//
//  SearchResultTableViewCell.swift
//  AppStoreSearch
//
//  Created by doremin on 2/5/24.
//

import UIKit

import Kingfisher
import RxSwift

final class SearchResultTableViewCell: BaseTableViewCell {
  // MARK: ReuseIdentifier
  static let reuseIdentifier = "SearchResultTalbeViewCell"
  
  // MARK: UI
  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.borderWidth = 1.0
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.layer.cornerRadius = 16
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let appLabelContainer = UIView()
  
  private let appTitleLabel: UILabel = {
    let label: UILabel = .make(
      "",
      size: 16,
      color: .white)
    label.numberOfLines = 1
    
    return label
  }()
  
  private let appDownloadButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: "icloud.and.arrow.down"),
      for: .normal)
    return button
  }()
  
  private let appCategoryLabel = UILabel
    .make(
      "",
      size: 14,
      color: .systemGray)
  
  // MARK: Layout
  override func addSubviews() {
    contentView.add {
      thumbnailImageView
      appLabelContainer.add {
        appTitleLabel
        appCategoryLabel
      }
      appDownloadButton
    }
  }
  
  override func setupConstraints() {
    thumbnailImageView.snp.makeConstraints { make in
      make.size.equalTo(70)
      make.top.left.equalTo(20)
    }
    
    appLabelContainer.snp.makeConstraints { make in
      make.left.equalTo(thumbnailImageView.snp.right).offset(15)
      make.centerY.equalTo(thumbnailImageView)
      make.height.equalTo(40)
      make.right.equalTo(appDownloadButton.snp.left).offset(-20)
    }
    
    appTitleLabel.snp.makeConstraints { make in
      make.top.right.left.equalToSuperview()
    }
    
    appCategoryLabel.snp.makeConstraints { make in
      make.left.bottom.equalToSuperview()
    }
    
    appDownloadButton.snp.makeConstraints { make in
      make.centerY.equalTo(thumbnailImageView)
      make.right.equalToSuperview().inset(20)
      make.size.equalTo(30)
    }
  }
  
  func bind(viewModel: SearchResultTableViewCellViewModel) {
    let input = SearchResultTableViewCellViewModel.Input()
    
    let output = viewModel.transform(input: input)
    
    output.displayScale
      .map { 1 / $0 }
      .bind(to: thumbnailImageView.layer.rx.borderWidth)
      .disposed(by: disposeBag)
    
    output.textColor
      .bind(to: appTitleLabel.rx.textColor)
      .disposed(by: disposeBag)
    
    output.searchResult
      .map { $0.artworkUrl60 }
      .subscribe(with: self, onNext: { owner, urlString in
        owner.thumbnailImageView
          .kf
          .setImage(
            with: URL(string: urlString),
            options: [
              .cacheMemoryOnly,
              .transition(.fade(0.25))
            ])
      })
      .disposed(by: disposeBag)
    
    output.searchResult
      .map { ($0.trackName, $0.primaryGenreName) }
      .subscribe(with: self, onNext: { owner, labelValues in
        let (titleText, categoryText) = labelValues
        
        owner.appTitleLabel.text = titleText
        owner.appCategoryLabel.text = categoryText
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: Prepare For Reuse
  override func prepareForReuse() {
    thumbnailImageView.kf.cancelDownloadTask()
    appTitleLabel.text = nil
    appCategoryLabel.text = nil
    disposeBag = DisposeBag()
  }
}

@available(iOS 17.0, *)
#Preview {
  let config = AppConfigurationImpl()
  let viewModel = SearchResultTableViewCellViewModel(
    appConfiguration: config,
    searchResult: .dummy)
  let cell = SearchResultTableViewCell()
  cell.bind(viewModel: viewModel)
  return cell
}
