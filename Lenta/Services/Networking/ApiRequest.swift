//
//  ApiRequest.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import Alamofire

struct ApiRequest: URLRequestConvertible {
    
    let url: URL
    let method: HTTPMethod
    var queryParams: Parameters?
    var bodyParams: Parameters?
    
    func asURLRequest() throws -> URLRequest {
        let defaultRequest = URLRequest(url: url)
        var request = try URLEncoding(destination: .queryString).encode(defaultRequest, with: queryParams)
        
        request.method = method
        
        if let bodyParams = bodyParams {
            request.httpBody = try bodyParams.toJsonData()
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
