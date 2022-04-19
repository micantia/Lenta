//
//  NewsListViewModel.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import RxSwift

final class NewsListViewModel {
    
    private let newsListService: NewsListServiceProtocol
    
    init(newsListService: NewsListServiceProtocol) {
        self.newsListService = newsListService
    }
    
    var newsListState: Observable<NewsListState> {
        newsListService.newsListState
    }
    
    func updateNewsList(with params: NewsListServiceParams) {
        newsListService.update(with: params)
    }
}
