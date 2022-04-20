//
//  RequestPatcher.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation
import Alamofire

protocol RequestPatcherProtocol {
    func patchedRequest(_ request: ApiRequest) -> ApiRequest
}

class RequestPatcher: RequestPatcherProtocol {
    
    private static let apiKey = "6835f8de9adc49ae863b397ae3e833a3"
    
    func patchedRequest(_ request: ApiRequest) -> ApiRequest {
        var mutableRequest = request
        
        var newQueryParams: Parameters {
            
            if var query = mutableRequest.queryParams {
                query["apiKey"] = RequestPatcher.apiKey
                return query
            } else {
                return ["apiKey": RequestPatcher.apiKey]
            }
            
        }
        mutableRequest.queryParams = newQueryParams
        return mutableRequest
    }
}

