//
//  AppCoordinator.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol AppCoordinatorDependencies: MovieListViewControllerDependencies {}

class AppCoordinator {
    private let window: UIWindow
    private let navigation = UINavigationController()
    private let dependencies: AppCoordinatorDependencies

    var isAnimated = true

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds), dependencies: AppCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        navigation.viewControllers = [searchVC]

        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    private func openListScreen() {
        navigation.pushViewController(MovieListViewController(dependencies: dependencies), animated: isAnimated)
    }
}

extension AppCoordinator: SearchViewControllerDelegate {
    func searchViewControllerDidRequestSearch(with term: String) {
        openListScreen()
    }
}
