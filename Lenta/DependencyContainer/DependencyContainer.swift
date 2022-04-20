//
//  DependencyContainer.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation

protocol NewsListViewModelFactoryProtocol {
    func makeNewsListViewModel() -> NewsListViewModel
}

final class DependencyContainer: NewsListViewModelFactoryProtocol {
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    func makeNewsListViewModel() -> NewsListViewModel {
        let networkingService = NetworkingService()
        let newsListService = NewsListService(networkingService: networkingService)
        return NewsListViewModel(newsListService: newsListService)
    }
    
}
