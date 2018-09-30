//
//  AppCoordinatorTests.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import CleanArchitecture

class AppCoordinatorTests: XCTestCase {
    private let window = UIWindow()
    private var coordinator: AppCoordinator!

    override func setUp() {
        coordinator = AppCoordinator(window: window)
    }

    func test_whenCoordinatorStarts_windowIsApplicationKeyWindow() {
        coordinator.start()

        expect(UIApplication.shared.keyWindow).to(equal(window))
    }

    func test_whenCoordinatorStarts_windowHasRootVC() {
        coordinator.start()

        expect(self.window.rootViewController).to(beAnInstanceOf(SearchViewController.self))
    }
}
