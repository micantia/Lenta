//
//  RootTabBarItem.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation
import UIKit

protocol RootBarItemProtocol: Hashable {
    var id: Int { get }
    var title: String { get }
    var activeIcon: UIImage? { get }
    var inActiveIcon: UIImage? { get }
}


enum RootBarItem: Int, RootBarItemProtocol, CaseIterable {
    case topHighlights = 0
    case search
    
    var id: Int {
        rawValue
    }
    
    var title: String {
        switch self {
        case .topHighlights:
            return L10n.RootTabBar.topHighlights
        case .search:
            return L10n.RootTabBar.search
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .topHighlights:
            return Asset.Images.TabBar.topActive.image
        case .search:
            return Asset.Images.TabBar.queryActive.image
        }
    }
    
    var inActiveIcon: UIImage? {
        switch self {
        case .topHighlights:
            return Asset.Images.TabBar.topInactive.image
        case .search:
            return Asset.Images.TabBar.queryInactive.image
        }
    }
}
