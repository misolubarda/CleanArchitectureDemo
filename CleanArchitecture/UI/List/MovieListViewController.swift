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
    @IBOutlet weak var tableView: UITableView!

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

        setupTableView()
        fetchMovies()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: dataSource.movieCellId)
        tableView.dataSource = dataSource
        dataSource.feedback = self
    }

    private func fetchMovies() {
        dataSource.search(for: searchTerm)
    }
}

extension MovieListViewController: MovieListTableDataSourceFeedback {
    func dataSourceDidUpdate() {
        tableView.reloadData()
    }
}
