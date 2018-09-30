//
//  AppCoordinator.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let navigation = UINavigationController()

    var isAnimated = true

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }

    func start() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        navigation.viewControllers = [searchVC]

        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    private func openListScreen() {
        navigation.pushViewController(ListViewController(), animated: isAnimated)
    }
}

extension AppCoordinator: SearchViewControllerDelegate {
    func searchViewControllerDidRequestSearch(with term: String) {
        openListScreen()
    }
}
