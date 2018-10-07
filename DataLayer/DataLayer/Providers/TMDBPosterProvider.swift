//
//  TMDBPosterProvider.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class TMDBPosterProvider: PosterProvider {
    private let service: WebService

    public convenience init() {
        self.init(service: WebServiceProvider(session: DataNetworkSession()))
    }

    init(service: WebService) {
        self.service = service
    }

    public func fetchPoster(with path: String, completion: @escaping (Response<Data>) -> Void) {
        guard let request = ImageRequest(path: path).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }
        service.execute(request, callback: completion)
    }
}
