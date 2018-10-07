//
//  PosterInteractorTests.swift
//  DomainLayerTests
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import DomainLayer

class PosterInteractorTests: XCTestCase {
    private let posters = [Poster(path: "somePath0", image: Data()),
                           Poster(path: "somePath1", image: Data()),
                           Poster(path: "somePath2", image: Data()),
                           Poster(path: "somePath3", image: Data())]
    private let providerFake = PosterProviderFake()
    private lazy var interactor = PosterInteractor(provider: providerFake)

    override func setUp() {
        providerFake.posters = posters
    }

    func test_fetchPosters_returnsFirstPosterData() {
        var result: [Poster] = []

        interactor.fetchPosters(with: posters.allPaths) { response in
            switch response {
            case let .success(poster):
                result.append(poster)
            default: break
            }
        }

        expect(result).to(contain(posters))
    }
}

private extension Array where Element == Poster {
    var allPaths: [String] { return self.map { $0.path } }
}

private class PosterProviderFake: PosterProvider {
    var posters: [Poster] = []

    func fetchPoster(with path: String, completion: @escaping (Response<Data>) -> Void) {
        let data = posters.first { $0.path == path }.map { $0.image }
        completion(.success(data!))
    }
}
