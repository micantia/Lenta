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

protocol NetworkingServiceFactoryProtocol {
    func makeNetworkingService(requestPatcher: RequestPatcherProtocol) -> NetworkingServiceProtocol
}

protocol NewsListServiceFactoryProtocol {
    func makeNewsListService(networkingService: NetworkingServiceProtocol) -> NewsListServiceProtocol
}

final class DependencyContainer:
    NewsListViewModelFactoryProtocol,
    NetworkingServiceFactoryProtocol,
    NewsListServiceFactoryProtocol
{
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    func makeNewsListViewModel() -> NewsListViewModel {
        let networkingService = makeNetworkingService()
        let newsListService = makeNewsListService(networkingService: networkingService)
        return NewsListViewModel(newsListService: newsListService)
    }
    
    func makeNetworkingService(
        requestPatcher: RequestPatcherProtocol = RequestPatcher()
    ) -> NetworkingServiceProtocol {
        return NetworkingService(requestPatcher: requestPatcher)
    }
    
    func makeNewsListService(
        networkingService: NetworkingServiceProtocol
    ) -> NewsListServiceProtocol {
        return NewsListService(networkingService: networkingService)
    }
    
}
