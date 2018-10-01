//
//  MovieSearchInteractorTests.swift
//  DomainLayerTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import DomainLayer

class MovieSearchInteractorTests: XCTestCase {
    func test_fetch_returnsDataFromProvider() {
        let providerFake = MovieSearchProviderFake()
        let interactor = MovieSearchInteractor(provider: providerFake)
        var result: Movies?

        interactor.query(for: "") { response in
            switch response {
            case let .success(movies):
                result = movies
            default: break
            }
        }

        expect(result).to(equal(providerFake.movies))
    }
}

private class MovieSearchProviderFake: MovieSearchProvider {
    var movies: Movies = [Movie(number: 0),
                          Movie(number: 1),
                          Movie(number: 2),
                          Movie(number: 3)]

    func query(for term: String, completion: (Response<Movies>) -> Void) {
        completion(.success(movies))
    }
}

extension Movie {
    init(number: Int) {
        self.init(posterPath: "posterPath\(number)", title: "title\(number)", release: Date(), overview: "overview\(number)")
    }
}
