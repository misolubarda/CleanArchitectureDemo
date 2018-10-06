//
//  MovieListTableDataSource.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 05.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol MovieListTableDataSourceFeedback: class {
    func dataSourceDidUpdate()
}

protocol MovieListTableDataSourceDependencies {
    var searchUseCase: MovieSearchUseCase { get }
}

class MovieListTableDataSource: NSObject {
    weak var feedback: MovieListTableDataSourceFeedback?
    let movieCellId = "movieCellIdentifier"
    private let dependencies: MovieListTableDataSourceDependencies
    private var movies = Movies()

    init(dependencies: MovieListTableDataSourceDependencies) {
        self.dependencies = dependencies
    }

    func search(for term: String) {
        dependencies.searchUseCase.query(for: term) { [weak self] response in
            switch response {
            case let .success(movies):
                self?.movies = movies
                self?.feedback?.dataSourceDidUpdate()
            case let .error(error):
                break
            }
        }
    }
}

extension MovieListTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellId, for: indexPath)
        if let movieCell = cell as? MovieCell {
            let movie = movies[indexPath.row]
            movieCell.setup(with: movie.title, release: movie.release, description: movie.overview, posterPath: movie.posterPath)
        }
        return cell
    }
}
