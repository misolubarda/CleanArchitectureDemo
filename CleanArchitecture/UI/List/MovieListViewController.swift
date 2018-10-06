//
//  ListViewController.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol MovieListViewControllerDependencies: MovieListTableDataSourceDependencies {}

class MovieListViewController: UIViewController {
    private let searchTerm: String
    private let dataSource: MovieListTableDataSource

    init(searchTerm: String, dependencies: MovieListViewControllerDependencies) {
        self.searchTerm = searchTerm
        dataSource = MovieListTableDataSource(dependencies: dependencies)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.search(for: searchTerm)
    }
}
