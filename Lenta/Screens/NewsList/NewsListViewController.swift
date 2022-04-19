//
//  NewsListViewController.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 18.04.22.
//

import UIKit

final class NewsListViewController: UIViewController {

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
        view.backgroundColor = Asset.Colors.white.color
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        applySnapshot(animated: false)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupView() {
        title = L10n.appTitle
        view.backgroundColor = Asset.Colors.white.color

        view.addSubview(collectionView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func applySnapshot(animated: Bool) {
        var snapshot = NewsListSnapshot()
        snapshot.appendSections(NewsListSections.allCases)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
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
