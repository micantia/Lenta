//
//  NewsListViewController.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 18.04.22.
//

import UIKit

final class NewsListViewController: UIViewController {

//    fileprivate enum CellIdentifier: String {
//        case newsList = "newsListCellIdentifier"
//    }
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = NewsColumnListLayoutHelper.getNewsColumnListLayout(
//            withInsets: .init(top: 16, leading: 16, bottom: 16, trailing: 16),
//            interGroupScaping: 16
//        )
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.register(
//            NewsItemCVCell.self,
//            forCellWithReuseIdentifier: CellIdentifier.newsList.rawValue
//        )
//        view.delegate = self
//        view.dataSource = self
//        view.backgroundColor = Asset.Colors.white.color
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupView() {
        title = L10n.appTitle
        view.backgroundColor = Asset.Colors.white.color
//
//        view.addSubview(collectionView)
//        let safeArea = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
//        ])
    }
    
}
//
//extension NewsListViewController: UICollectionViewDelegate {}
//
//// MARK: - UICollectionViewDataSource conformance
//extension NewsListViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: CellIdentifier.newsList.rawValue,
//            for: indexPath
//        ) as! NewsItemCVCell
//
//
//        cell.configure(
//            title: "Hello Lenta",
//            subtitle: "Hello Lenta\naskdlfkasd;lfka;sdlkf'als;dkf'als;dkf'as;dlkf'dl;f\n ;lk",
//            image: nil
//        )
//
//        return cell
//    }
//
//}
