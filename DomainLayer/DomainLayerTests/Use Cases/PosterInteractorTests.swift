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
    func test_fetch_returnsDataFromProvider() {
        let providerFake = PosterProviderFake()
        let interactor = PosterInteractor(provider: providerFake)
        var result: Poster?

        interactor.fetchPosters(with: [""]) { response in
            switch response {
            case let .success(poster):
                result = poster
            default: break
            }
        }

        expect(result).to(equal(providerFake.poster))
    }
}

private class PosterProviderFake: PosterProvider {
    var poster: Poster = Poster(path: "somePath", image: Data())

    func fetchPosters(with paths: [String], completion: @escaping (Response<Poster>) -> Void) {
        completion(.success(poster))
    }
}
