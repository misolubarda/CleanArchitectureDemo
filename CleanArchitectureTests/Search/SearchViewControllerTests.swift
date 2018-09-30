//
//  SearchViewControllerTests.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import CleanArchitecture

class SearchViewControllerTests: XCTestCase {
    func test_initWithEncoder_returnsNil() {
        let vc = SearchViewController(coder: NSCoder())

        expect(vc).to(beNil())
    }

    func test_init_returnsAnInstance() {
        let vc = SearchViewController()

        expect(vc).notTo(beNil())
    }
}
