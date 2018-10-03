//
//  WebServiceFake.swift
//  DataLayerTests
//
//  Created by Lubarda, Miso on 03.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer
@testable import DataLayer

class WebServiceFake: WebService {
    var request: URLRequest?
    var error: Error?
    var result: Decodable?

    func execute<T>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void) where T : Decodable {
        self.request = request
        if let error = error {
            callback(.error(error))
            return
        }
        callback(.success(result as! T))
    }
}
