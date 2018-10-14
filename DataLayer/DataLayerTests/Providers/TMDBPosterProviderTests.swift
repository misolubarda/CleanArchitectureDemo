//
//  TMDBPosterProviderTests.swift
//  DataLayerTests
//
//  Created by Lubarda, Miso on 07.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
import DomainLayer
@testable import DataLayer

class TMDBPosterProviderTests: XCTestCase {
    private let webServiceFake = WebServiceFake()
    private var provider: TMDBPosterProvider!

    override func setUp() {
        webServiceFake.result = Data()
        provider = TMDBPosterProvider(service: webServiceFake)
    }

    // MARK: Request

    func test_fetchPoster_request_hasCorrectHost() {
        provider.fetchPoster(with: "") {_ in }

        expect(self.webServiceFake.request?.url?.host).to(equal("image.tmdb.org"))
    }

    func test_fetchPoster_request_hasCorrectApiPath() {
        provider.fetchPoster(with: "") {_ in }

        expect(self.webServiceFake.request?.url?.pathComponents[1]).to(equal("t"))
        expect(self.webServiceFake.request?.url?.pathComponents[2]).to(equal("p"))
    }

    func test_fetchPoster_request_hasCorrectPosterSizePath() {
        provider.fetchPoster(with: "") {_ in }

        expect(self.webServiceFake.request?.url?.pathComponents[3]).to(contain("w92"))
    }

    func test_fetchPoster_request_hasCorrectPosterPath() {
        let expectedPath = "somePath"

        provider.fetchPoster(with: expectedPath) {_ in }

        expect(self.webServiceFake.request?.url?.absoluteString).to(contain(expectedPath))
    }

    // MARK: Response

    func test_fetchPoster_onSearchResultsResponse_resultIsSuccess() {
        var success = false

        provider.fetchPoster(with: "") { response in
            switch response {
            case .success:
                success = true
            default: break
            }
        }

        expect(success).to(beTrue())
    }

    func test_fetchPoster_onErrorResponse_resultIsError() {
        webServiceFake.error = NSError(domain: "domain", code: 400)
        let provider = TMDBPosterProvider(service: webServiceFake)
        var error = false

        provider.fetchPoster(with: "") { response in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }

    // MARK: Caching

    func test_fetchPoster_retrivesStoredResultFromCache() {
        var success = false
        let posterPath = "posterPath"
        provider.fetchPoster(with: posterPath) { _ in }

        webServiceFake.result = nil
        provider.fetchPoster(with: posterPath) { response in
            switch response {
            case .success:
                success = true
            default: break
            }
        }

        expect(success).to(beTrue())
    }
}
