//
//  UsersRouter.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Alamofire
import Foundation

enum UsersEndpoint {
    case getUsers
}

class UsersRouter: BaseRouter {
    fileprivate var endPoint: UsersEndpoint

    init(anEndpoint: UsersEndpoint) {
        endPoint = anEndpoint
    }

    override var method: HTTPMethod {
        switch endPoint {
        case .getUsers: return .get
        }
    }

    override var path: String {
        switch endPoint {
        case .getUsers:
            return "users"
        }
    }

    override var parameters: Parameters? {
        switch endPoint {
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
