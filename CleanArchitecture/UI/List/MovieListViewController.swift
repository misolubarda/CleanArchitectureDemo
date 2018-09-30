//
//  ListViewController.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol MovieListViewControllerDependencies {
    var searchUseCase: MovieSearchUseCase { get }
}

class MovieListViewController: UIViewController {
    private let dependencies: MovieListViewControllerDependencies

    init(dependencies: MovieListViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
