//
//  NetworkingService.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkingServiceProtocol {
    func requestData(_ request: ApiRequest) -> Single<Data>
    func requestDecodable<Response: Decodable>(_ request: ApiRequest, type: Response.Type) -> Single<Response>
}

final class NetworkingService: NetworkingServiceProtocol {
    
    private let requestPatcher: RequestPatcherProtocol?
    
    init(requestPatcher: RequestPatcherProtocol? = nil) {
        self.requestPatcher = requestPatcher
    }
    
    func requestData(_ request: ApiRequest) -> Single<Data> {
        let patchedRequset = requestPatcher?.patchedRequest(request) ?? request
        return Single.create { single in
            AF.request(patchedRequset)
                .response { response in
                    if let data = response.data {
                        single(.success(data))
                    }
                    if let error = response.error {
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
    
    func requestDecodable<Response>(_ request: ApiRequest, type: Response.Type) -> Single<Response> where Response : Decodable {
        return requestData(request)
            .map { try! JSONDecoder().decode(type, from: $0) }
    }
    
}
