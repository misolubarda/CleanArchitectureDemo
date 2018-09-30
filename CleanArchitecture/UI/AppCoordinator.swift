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

    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
    }
}
