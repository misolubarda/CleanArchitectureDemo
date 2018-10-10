//
//  WebServiceTests.swift
//  DataLayerTests
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
import DomainLayer
@testable import DataLayer

class WebServiceTests: XCTestCase {
    func test_execute_whenDecodableObjectExpected_respondsWithTheObject() {
        let sessionFake = NetworkSessionFake()
        let movieData = Data.movie
        sessionFake.data = movieData
        let service = WebServiceProvider(session: sessionFake)
        var result: Movie?

        service.execute(URLRequest.fake) { (response: Response<Movie>) in
            switch response {
            case let .success(movie):
                result = movie
            default: break
            }
        }

        expect(result).to(equal(movieData.decodedMovie))
    }

    func test_execute_whenDataObjectExpected_respondsWithData() {
        let sessionFake = NetworkSessionFake()
        sessionFake.data = Data.movie
        let service = WebServiceProvider(session: sessionFake)
        var result: Data?

        service.execute(URLRequest.fake) { (response: Response<Data>) in
            switch response {
            case let .success(data):
                result = data
            default: break
            }
        }

        expect(result).to(equal(Data.movie))
    }

    func test_execute_onError_returnsError() {
        let sessionFake = NetworkSessionFake()
        sessionFake.error = NSError(domain: "someDomain", code: 400, userInfo: nil)
        let service = WebServiceProvider(session: sessionFake)
        var error: Bool?

        service.execute(URLRequest.fake) { (response: Response<Movie>) in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }

    func test_execute_onDataNotParsable_returnsDecodingError() {
        let sessionFake = NetworkSessionFake()
        sessionFake.data = Data.movieWithMissingData
        let service = WebServiceProvider(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<Movie>) in
            switch response {
            case let .error(error):
                result = error
            default: break
            }
        }

        expect(result).to(beAnInstanceOf(DecodingError.self))
    }

    func test_execute_onNoErrorNorData_returnsSpecificError() {
        let sessionFake = NetworkSessionFake()
        let service = WebServiceProvider(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<Movie>) in
            switch response {
            case let .error(error):
                result = error
            default: break
            }
        }

        expect(result).to(beAnInstanceOf(WebServiceError.self))
    }
}

private extension Data {
    static var movie: Data {
        return """
        {"vote_count":3173,
        "id":268,
        "video":false,
        "vote_average":7.1,
        "title":"Batman",
        "popularity":12.65,
        "poster_path":"/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg",
        "original_language":"en",
        "original_title":"Batman",
        "genre_ids":[14,28],
        "backdrop_path":"/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg",
        "adult":false,
        "overview":"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.",
        "release_date":"1989-06-23"}
        """.data(using: .utf8)!
    }

    static var movieWithMissingData: Data {
        return """
        {"vote_count":3173,
        "title":"Batman",
        "release_date":"1989-06-23"}
        """.data(using: .utf8)!
    }

    var decodedMovie: Movie {
        return try! JSONDecoder().decode(Movie.self, from: self)
    }
}

private extension URLRequest {
    static var fake: URLRequest {
        return URLRequest(url: URL(string: "http://www.something.si")!)
    }
}
