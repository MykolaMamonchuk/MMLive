//
//  APIManager.swift
//
//  Created by Selecto.
//

import Alamofire
import Foundation

typealias Response<T> = (Result<T, APIError>) -> Void
typealias EmptyResponse = (Result<Void, APIError>) -> Void

final class APIManager {
    // MARK: -

    // MARK: Shared Instance

    // MARK: -

    public static let sI = APIManager()

    // MARK: -

    // MARK: Perform request methods

    // MARK: -

    fileprivate func performRequest<T: Codable>(router: BaseRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping Response<T>) {
        AF.request(router).validate(statusCode: 200 ..< 300).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in

            let statusCode = response.response?.statusCode ?? -1

            switch response.result {
            case let .success(object):
                completion(.success(object))
            case let .failure(err):
                if response.data == nil {
                    completion(.failure(.failedAPICall(err.localizedDescription, code: err.responseCode ?? -1)))
                } else {
                    completion(.failure(self.parseCustomErrorData(data: response.data, statusCode, err.localizedDescription)))
                }
            }
        }
    }

    fileprivate func performRequest(router: BaseRouter, completion: @escaping EmptyResponse) {
        AF.request(router).validate().response { response in

            let statusCode = response.response?.statusCode ?? -1

            switch response.result {
            case .success:
                completion(.success(()))
            case let .failure(err):
                if response.data == nil {
                    completion(.failure(.failedAPICall(err.localizedDescription, code: statusCode)))
                } else {
                    completion(.failure(self.parseCustomErrorData(data: response.data, statusCode, err.localizedDescription)))
                }
            }
        }
    }

    fileprivate func performUpload(router: BaseRouter, onProgress: @escaping (Float?) -> Void, completion: @escaping EmptyResponse) {
        let formData = MultipartFormData(fileManager: .default, boundary: "custom-test-boundary")

        if let params = router.parameters {
            for (key, value) in params {
                if value is UIImage {
                    if let imageData = (value as? UIImage)?.jpegData(compressionQuality: 0.5), !imageData.isEmpty {
                        formData.append(imageData, withName: key, fileName: UUID().uuidString + ".jpg", mimeType: "image/jpeg")
                    } else if let imageData = (value as? UIImage)?.pngData() {
                        formData.append(imageData, withName: key, fileName: UUID().uuidString + ".png", mimeType: "image/png")
                    }
                }
                if value is Data {
                    if let videoData = value as? Data {
                        formData.append(videoData, withName: key, fileName: UUID().uuidString + ".mp4", mimeType: "video/mp4")
                    }
                }
            }
        }

        AF.upload(multipartFormData: formData, with: router)
            .uploadProgress(queue: .main, closure: { progress in
                // Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
                onProgress(Float(progress.fractionCompleted))
            })
            .validate(statusCode: 200 ..< 300)
            .response(completionHandler: { response in
                let statusCode = response.response?.statusCode ?? -1

                switch response.result {
                case .success:
                    completion(.success(()))
                case let .failure(err):
                    if response.data == nil {
                        completion(.failure(.failedAPICall(err.localizedDescription, code: err.responseCode ?? -1)))
                    } else {
                        completion(.failure(self.parseCustomErrorData(data: response.data, statusCode, err.localizedDescription)))
                    }
                }
            })
    }

    /**
     An example of custom response
     ````
     ///{
     ///  "error": [{
     ///           "constraints": {
     ///        "isPhoneNumber": "phone must be a valid phone number"
     ///      }
     ///    }]
     ///}
     ````
     */

    fileprivate func parseCustomErrorData(data: Data?, _ status: Int, _ message: String? = nil) -> APIError {
        guard let data = data else { return .failedAPICall(message, code: status) }
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            if let responseMessage = String(data: data, encoding: .utf8) {
                return .failedAPICall(responseMessage, code: status)
            }
            return .failedAPICall(message, code: status)
        }

        guard let messageBlock = json["error"] as? [String: Any] else {
            return .failedAPICall(code: status)
        }

        let mesages = messageBlock["message"] as? String

        return .failedAPICall(mesages, code: status)
    }

    // -------------------------------------------------------------------------------------------

    // MARK: - USERS FLOW METHODS

    // -------------------------------------------------------------------------------------------
    /// Method for getting userml.
    ///    - Parameters:
    ///    - completion: A closure to be executed once the request has finished.
    ///
    ///    - Returns:             Nothing. Use closure
    ///
    ///    ~~~
    ///    DispatchQueue.main.async {
    ///        APIManager.sI().getUsersList() { [weak self] result in
    ///            guard let strongSelf = self else { return }
    ///
    ///            switch result {
    ///            case let .success(response):
    ///                print(response)
    ///            case let .failure(errMsg):
    ///                Utils.standartAlertMessage(message: errMsg.errMessage(), title: errorTitle)
    ///            }
    ///        }
    ///    }
    ///    ~~~
    ///
    func getUsersList(completion: @escaping Response<[UserML]>) {
        let router = UsersRouter(anEndpoint: .getUsers)
        performRequest(router: router, completion: completion)
    }
}
