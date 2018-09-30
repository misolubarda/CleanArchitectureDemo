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
    private var delegateFake = SearchDelegateFake()
    private var viewController = SearchViewController()

    // MARK: Initialization

    func test_initWithEncoder_returnsNil() {
        let vc = SearchViewController(coder: NSCoder())

        expect(vc).to(beNil())
    }

    func test_init_returnsAnInstance() {
        let vc = SearchViewController()

        expect(vc).notTo(beNil())
    }

    // MARK: SearchViewControllerDelegate

    func test_onSearchButtonTap_delegateIsInformed() {
        _ = viewController.view
        let searchTerm = "some term"
        viewController.searchTextField.text = searchTerm
        viewController.delegate = delegateFake

        viewController.searchButtonTouchedUpInside(UIButton())

        expect(self.delegateFake.lastSearchTerm).to(equal(searchTerm))
    }

    func test_onSearchButtonTap_whenNoSearchTerm_delegateIsNotInformed() {
        _ = viewController.view
        viewController.delegate = delegateFake

        viewController.searchButtonTouchedUpInside(UIButton())

        expect(self.delegateFake.lastSearchTerm).to(beNil())
    }
}

private class SearchDelegateFake: SearchViewControllerDelegate {
    var lastSearchTerm: String?

    func searchViewControllerDidRequestSearch(with term: String) {
        lastSearchTerm = term
    }
}
