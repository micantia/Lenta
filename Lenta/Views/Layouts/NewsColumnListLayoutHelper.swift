//
//  NewsColumnListLayoutHelper.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 18.04.22.
//

import Foundation
import UIKit

final class NewsColumnListLayoutHelper {
    
    static func getNewsColumnListLayout(
        withInsets sectionInsets: NSDirectionalEdgeInsets = .zero,
        interItemSpacing: NSCollectionLayoutSpacing = .fixed(0),
        interGroupScaping: CGFloat = 0
    ) -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = interItemSpacing
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        section.interGroupSpacing = interGroupScaping
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
