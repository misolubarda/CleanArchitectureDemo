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
    func test_execute_whenSuccessful_returnsSuccess() {
        let sessionFake = NetworkSessionFake()
        sessionFake.data = Data.movie
        let service = WebService(session: sessionFake)
        var success: Bool?

        service.execute(URLRequest.fake) { (response: Response<MovieFake>) in
            switch response {
            case .success:
                success = true
            default: break
            }
        }

        expect(success).to(beTrue())
    }

    func test_execute_onError_returnsError() {
        let sessionFake = NetworkSessionFake()
        sessionFake.error = NSError(domain: "someDomain", code: 400, userInfo: nil)
        let service = WebService(session: sessionFake)
        var error: Bool?

        service.execute(URLRequest.fake) { (response: Response<MovieFake>) in
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
        let service = WebService(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<MovieFake>) in
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
        let service = WebService(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<MovieFake>) in
            switch response {
            case let .error(error):
                result = error
            default: break
            }
        }

        expect(result).to(beAnInstanceOf(WebServiceError.self))
    }
}

private struct MovieFake: Decodable {
    let poster_path: String
    let title: String
    let release_date: String
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
}

private extension URLRequest {
    static var fake: URLRequest {
        return URLRequest(url: URL(string: "http://www.something.si")!)
    }
}
