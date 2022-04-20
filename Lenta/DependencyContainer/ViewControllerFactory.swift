//
//  ViewControllerFactory.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation

final class ViewControllerFactory {
    
    static func makeNewsListViewController(
        dependencyContainer: NewsListViewModelFactoryProtocol
    ) -> NewsListViewController {
        
        let controller = NewsListViewController()
        controller.viewModel = dependencyContainer.makeNewsListViewModel()
        return controller
        
    }
    
}
