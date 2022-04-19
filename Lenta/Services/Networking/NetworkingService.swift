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
    
    private static let apiKey = "6835f8de9adc49ae863b397ae3e833a3"
    
    private func patchedRequest(_ request: ApiRequest) -> ApiRequest {
        var mutableRequest = request
        
        var newQueryParams: Parameters {
            
            if var query = mutableRequest.queryParams {
                query["apiKey"] = NetworkingService.apiKey
                return query
            } else {
                return ["apiKey": NetworkingService.apiKey]
            }
            
        }
        mutableRequest.queryParams = newQueryParams
        return mutableRequest
    }
    
    func requestData(_ request: ApiRequest) -> Single<Data> {
        let patchedRequset = patchedRequest(request)
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
