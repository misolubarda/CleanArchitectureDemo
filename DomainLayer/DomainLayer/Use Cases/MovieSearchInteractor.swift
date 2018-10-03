//
//  MovieSearchInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public class MovieSearchInteractor: MovieSearchUseCase {
    private let provider: MovieSearchProvider

    public init(provider: MovieSearchProvider) {
        self.provider = provider
    }

    public func query(for term: String, completion: @escaping (Response<Movies>) -> Void) {
        provider.query(for: term, completion: completion)
    }
}
