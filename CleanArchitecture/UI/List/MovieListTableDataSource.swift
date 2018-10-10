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
    var posterUseCase: PosterUseCase { get }
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

    func updatePosters(for indexPaths: [IndexPath], in tableView: UITableView) {
        guard let first = indexPaths.first?.row, let last = indexPaths.last?.row, last >= first else { return }
        let posterPaths = movies[first...last].compactMap { $0.posterPath }
        dependencies.posterUseCase.fetchPosters(with: posterPaths) { [weak self] response in
            switch response {
            case let .success(poster):
                self?.updateVisibleCells(with: poster, in: tableView)
            case .error: break
            }
        }
    }

    private func updateVisibleCells(with poster: Poster, in tableView: UITableView) {
        guard let cells = tableView.visibleCells as? [MovieCell],
            let cell = cells.first(where: { $0.posterPath == poster.path }),
            let image = UIImage(data: poster.image) else { return }

        cell.updatePosterImage(image)
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
