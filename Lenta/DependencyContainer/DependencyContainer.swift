//
//  DependencyContainer.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation

final class DependencyContainer {
    
    static func makeNewsListViewModel() -> NewsListViewModel {
        
        let networkingService = NetworkingService()
        let newsListService = NewsListService(networkingService: networkingService)
        return NewsListViewModel(newsListService: newsListService)
    }
    
}
