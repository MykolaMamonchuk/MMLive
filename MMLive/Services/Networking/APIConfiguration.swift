//
//  APIConfiguration.swift
//
//  Created by Selecto.
//

import Alamofire
import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var encoding: Alamofire.ParameterEncoding? { get }
}
