//
//  NewsListService.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import RxSwift

typealias NewsListState = ModelState<[NewsItem]>

protocol NewsListServiceProtocol {
    var newsListState: Observable<NewsListState> { get }
    func update(with params: NewsListServiceParams)
}

final class NewsListService: NewsListServiceProtocol {
    
    private let networkingService: NetworkingServiceProtocol
    
    private let updateSubject = PublishSubject<NewsListServiceParams>()
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    var newsListState: Observable<NewsListState> {
        updateSubject
            .flatMapLatest { [weak self] params -> Observable<NewsListState> in
                guard let self = self else { return Observable.never() }
                return self.getNewsListState(params: params)
            }
    }
    
    func update(with params: NewsListServiceParams) {
        updateSubject.onNext(params)
    }
    
    private func fetchNews(params: NewsListServiceParams) -> Single<NewsItemsRs> {
        let request = ApiRequest(
            url: URL(string: "https://newsapi.org/v2/everything")!,
            method: .get,
            queryParams: [
                "q": params.query
            ],
            bodyParams: nil
        )
        
        return networkingService.requestDecodable(request, type: NewsItemsRs.self)
    }
    
    private func getNewsListState(params: NewsListServiceParams) -> Observable<NewsListState> {
        fetchNews(params: params)
            .map { response -> NewsListState in
                if let newsList = response.articles, response.status == "ok" {
                    return .loaded(newsList)
                } else {
                    return .error(ModelStateError.StatusError)
                }
            }
            .catch { error in .error(error) }
            .asObservable()
            .startWith(.loading)
    }
    
}
