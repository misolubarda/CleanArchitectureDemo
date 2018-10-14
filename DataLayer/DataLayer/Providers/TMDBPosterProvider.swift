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
    private var postersCache: [String: Data] = [:]

        public typealias PosterCompletion = ((Response<Data>) -> Void)

    public convenience init() {
        self.init(service: WebServiceProvider(session: DataNetworkSession()))
    }

    init(service: WebService) {
        self.service = service
    }

    public func fetchPoster(with path: String, completion: @escaping PosterCompletion) {
        if let posterData = postersCache[path] {
            completion(.success(posterData))
            return
        }

        guard let request = ImageRequest(path: path).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }
        let callback = storeInCache(path: path, completion)
        service.execute(request, callback: callback)
    }

    private func storeInCache(path: String, _ completion: @escaping PosterCompletion) -> PosterCompletion {
        return { [weak self] response in
            if case let .success(data) = response {
                self?.postersCache[path] = data
            }
            completion(response)
        }
    }
}
