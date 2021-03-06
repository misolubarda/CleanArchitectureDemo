//
//  WebService.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

protocol WebService: class {
    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void)
}

class WebServiceProvider: WebService {
    private let session: NetworkSession

    init(session: NetworkSession) {
        self.session = session
    }

    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void) {
        session.perform(with: request) { [weak self] (data, response, error) in
            self?.handleResponse(data, httpResponse: response as? HTTPURLResponse, error: error, callback: callback)
        }
    }

    private func handleResponse<T: Decodable>(_ data: Data?, httpResponse: HTTPURLResponse?, error: Error?, callback: (Response<T>) -> Void) {
        if let error = error {
            callback(.error(error))
        } else if let data = data  {
            if T.self == Data.self {
                callback(.success(data as! T))
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                callback(.success(result))
            } catch let error {
                callback(.error(error))
            }
        } else {
            callback(.error(WebServiceError.ambigousResponse))
        }
    }
}

enum WebServiceError: Error {
    case ambigousResponse
}
