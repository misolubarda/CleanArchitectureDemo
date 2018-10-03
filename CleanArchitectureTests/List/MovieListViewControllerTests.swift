//
//  ListViewControllerTests.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import CleanArchitecture

class MovieListViewControllerTests: XCTestCase {
    private var viewController: MovieListViewController!

    override func setUp() {
        let dependencies = AppDependenciesFake()
        viewController = MovieListViewController(searchTerm: "", dependencies: dependencies)
    }

    // MARK: Initialization

    func test_initWithEncoder_returnsNil() {
        let vc = MovieListViewController(coder: NSCoder())

        expect(vc).to(beNil())
    }

    func test_init_returnsAnInstance() {
        expect(self.viewController).notTo(beNil())
    }
}
