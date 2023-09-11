//
//  ExampleRouter.swift
//
//  Created by Selecto.
//

import Alamofire
import Foundation

enum ExampleEndpoint {
    case getSomeData(Parameters)
}

class ExampleRouter: BaseRouter {
    fileprivate var endPoint: ExampleEndpoint

    init(anEndpoint: ExampleEndpoint) {
        endPoint = anEndpoint
    }

    override var method: HTTPMethod {
        switch endPoint {
        case .getSomeData: return .get
        }
    }

    override var path: String {
        switch endPoint {
        case .getSomeData:
            return "Example/Data"
        }
    }

    override var parameters: Parameters? {
        switch endPoint {
        case let .getSomeData(params): return params
        default: return nil
        }
    }

    override var keyPath: String? {
        return nil
    }

    override var encoding: ParameterEncoding? {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
