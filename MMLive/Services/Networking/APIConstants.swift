//
//  APIConstants.swift
//
//  Created by Selecto.
//

import Alamofire
import Foundation

// MARK: -

// MARK: Default constants

// MARK: -

struct APIConstants {
    static let baseURL = "https://api.github.com/"
    static let baseAPIVersion = ""
    static let contentType = "application/json"
}

// MARK: -

// MARK: Default messages for responses

// MARK: -

let requestErrorMessage = "Oops! Something went wrong."

// MARK: -

// MARK: Other methods

// MARK: -

enum APIError: Error {
    case failedAPICall(String? = nil, code: Int)

    func errMessage() -> String {
        switch self { case let .failedAPICall(message, _): return message ?? requestErrorMessage }
    }

    func errCode() -> Int {
        switch self { case let .failedAPICall(_, code): return code }
    }

    public var localizedDescription: String {
        return errMessage().isEmpty ? self.localizedDescription : errMessage()
    }

    public var statusCode: Int { return errCode() }
}
