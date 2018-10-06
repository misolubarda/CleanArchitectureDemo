//
//  PosterInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public class PosterInteractor: PosterUseCase {
    private let provider: PosterProvider

    public init(provider: PosterProvider) {
        self.provider = provider
    }

    public func fetchPosters(with paths: [String], completion: @escaping (Response<Poster>) -> Void) {
        provider.fetchPosters(with: paths, completion: completion)
    }
}
