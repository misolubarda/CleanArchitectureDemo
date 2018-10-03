//
//  TMDBMovieSearchProviderTests.swift
//  DataLayerTests
//
//  Created by Lubarda, Miso on 03.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
import DomainLayer
@testable import DataLayer

class TMDBMovieSearchProviderTests: XCTestCase {
    private let webServiceFake = WebServiceFake()

    override func setUp() {
        webServiceFake.result = MovieSearchResponse(results: [Movie()])
    }

    // MARK: Request

    func test_query_request_hasCorrectHost() {
        let provider = TMDBMovieSearchProvider(service: webServiceFake)

        provider.query(for: "") {_ in }

        expect(self.webServiceFake.request?.url?.host).to(equal("api.themoviedb.org"))
    }

    func test_query_request_hasCorrectApiVersion() {
        let provider = TMDBMovieSearchProvider(service: webServiceFake)

        provider.query(for: "") {_ in }

        expect(self.webServiceFake.request?.url?.pathComponents[1]).to(equal("3"))
    }

    func test_query_request_hasCorrectEndpointPath() {
        let provider = TMDBMovieSearchProvider(service: webServiceFake)

        provider.query(for: "") {_ in }

        expect(self.webServiceFake.request?.url?.absoluteString).to(contain("search/movie"))
    }

    func test_query_request_hasCorrectApiKey() {
        let provider = TMDBMovieSearchProvider(service: webServiceFake)

        provider.query(for: "") {_ in }

        expect(self.webServiceFake.request?.url?.absoluteString).to(contain("api_key=2696829a81b1b5827d515ff121700838"))
    }

    func test_query_request_hasCorrectSearchTerm() {
        let expectedTerm = "movieName"
        let provider = TMDBMovieSearchProvider(service: webServiceFake)

        provider.query(for: expectedTerm) {_ in }

        expect(self.webServiceFake.request?.url?.absoluteString).to(contain("query=\(expectedTerm)"))
    }

    // MARK: Response

    func test_query_onSearchResultsResponse_resultIsSuccess() {
        let provider = TMDBMovieSearchProvider(service: webServiceFake)
        var success = false

        provider.query(for: "") { response in
            switch response {
            case .success:
                success = true
            default: break
            }
        }

        expect(success).to(beTrue())
    }

    func test_query_onErrorResponse_resultIsError() {
        webServiceFake.error = NSError(domain: "domain", code: 400)
        let provider = TMDBMovieSearchProvider(service: webServiceFake)
        var error = false

        provider.query(for: "") { response in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }
}


