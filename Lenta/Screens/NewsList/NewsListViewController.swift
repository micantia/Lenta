//
//  NewsListViewController.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 18.04.22.
//

import UIKit
import RxSwift

final class NewsListViewController: UIViewController {

    var viewModel: NewsListViewModel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource: NewsListDataSource = {
        let dataSource = NewsListDataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifier.newsList.rawValue,
                for: indexPath
            ) as! NewsItemCVCell
            
            cell.configure(
                title: itemIdentifier.title,
                subtitle: itemIdentifier.description,
                imageUrl: itemIdentifier.urlToImage
            )
            
            return cell
        }
        
        return dataSource
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = NewsColumnListLayoutHelper.getNewsColumnListLayout(
            withInsets: .init(top: 16, leading: 16, bottom: 16, trailing: 16),
            interGroupScaping: 16
        )
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(
            NewsItemCVCell.self,
            forCellWithReuseIdentifier: CellIdentifier.newsList.rawValue
        )
        view.backgroundColor = Asset.Colors.zircon.color
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindObservables()
        
        viewModel.updateNewsList(with: NewsListServiceParams(query: "bitcoin"))
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupView() {
        title = L10n.appTitle
        view.backgroundColor = Asset.Colors.zircon.color

        view.addSubview(collectionView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func applySnapshot(_ items: [NewsItem], animated: Bool) {
        var snapshot = NewsListSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    private func bindObservables() {
        viewModel.newsListState
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .loading:
                    print("loading")
                case let .loaded(newsItems):
                    self?.applySnapshot(newsItems, animated: true)
                case let .error(error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension NewsListViewController {
    enum NewsListSections: CaseIterable {
        case main
    }
    
    typealias NewsListDataSource = UICollectionViewDiffableDataSource<NewsListSections, NewsItem>
    typealias NewsListSnapshot = NSDiffableDataSourceSnapshot<NewsListSections, NewsItem>
    
    enum CellIdentifier: String {
        case newsList = "newsListCellIdentifier"
    }

}
