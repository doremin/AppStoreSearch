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
  private let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.borderWidth = 1.0
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.layer.cornerRadius = 16
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let thumbnailImageContainer: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 5
    stackView.distribution = .fillEqually
    return stackView
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

  private func thumbnailImageViewsFactory(
    result: SearchResponse.SearchResult)
  -> [UIImageView]
  {
    return result.screenshotUrls
      .enumerated()
      .filter { $0.offset < 3 }
      .map { URL(string: $0.element) }
      .map { url in
        let imageView = UIImageView()
        imageView
          .kf
          .setImage(
            with: url,
            options: [
              .cacheMemoryOnly,
              .transition(.fade(0.25))
            ])
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
      }
  }
  
  // MARK: Layout
  override func addSubviews() {
    contentView.add {
      appIconImageView
      appLabelContainer.add {
        appTitleLabel
        appCategoryLabel
      }
      appDownloadButton
      thumbnailImageContainer
    }
  }
  
  override func setupConstraints() {
    appIconImageView.snp.makeConstraints { make in
      make.size.equalTo(70)
      make.top.left.equalTo(20)
    }
    
    appLabelContainer.snp.makeConstraints { make in
      make.left.equalTo(appIconImageView.snp.right).offset(15)
      make.centerY.equalTo(appIconImageView)
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
      make.centerY.equalTo(appIconImageView)
      make.right.equalToSuperview().inset(20)
      make.size.equalTo(30)
    }
    
    thumbnailImageContainer.snp.makeConstraints { make in
      make.top.equalTo(appIconImageView.snp.bottom).offset(20)
      make.left.equalTo(appIconImageView)
      make.right.equalTo(appDownloadButton)
      make.height.equalTo(280)
    }
  }
  
  func bind(viewModel: SearchResultTableViewCellViewModel) {
    let input = SearchResultTableViewCellViewModel.Input()
    
    let output = viewModel.transform(input: input)
    
    output.displayScale
      .map { 1 / $0 }
      .bind(to: appIconImageView.layer.rx.borderWidth)
      .disposed(by: disposeBag)
    
    output.textColor
      .bind(to: appTitleLabel.rx.textColor)
      .disposed(by: disposeBag)
    
    output.searchResult
      .map { $0.artworkUrl60 }
      .subscribe(with: self, onNext: { owner, urlString in
        owner.appIconImageView
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
    
    output.searchResult
      .withUnretained(self)
      .map { owner, result in
        owner.thumbnailImageViewsFactory(result: result)
      }
      .subscribe(with: self, onNext: { owner, imageViews in
        imageViews
          .forEach { owner.thumbnailImageContainer.addArrangedSubview($0) }
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: Prepare For Reuse
  override func prepareForReuse() {
    appIconImageView.kf.cancelDownloadTask()
    appTitleLabel.text = nil
    appCategoryLabel.text = nil
    disposeBag = DisposeBag()
    thumbnailImageContainer.subviews
      .forEach { $0.removeFromSuperview() }
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
