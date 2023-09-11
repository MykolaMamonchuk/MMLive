//
//  BaseRouter.swift
//
//  Created by Selecto.
//

import Alamofire
import Foundation

class BaseRouter: APIConfiguration {
    init() {}

    var encoding: ParameterEncoding? {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }

    var method: HTTPMethod {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }

    var path: String {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }

    var parameters: Parameters? {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }

    var keyPath: String? {
        fatalError("[\(self) - \(#function))] Must be overridden in subclass")
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 25
        urlRequest.setValue(APIConstants.contentType, forHTTPHeaderField: "Content-Type")

        if let encoding = encoding {
            return try encoding.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
