//
//  MovieListTableDataSource.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 05.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

protocol MovieListTableDataSourceDependencies {
    var searchUseCase: MovieSearchUseCase { get }
}

class MovieListTableDataSource {
    private let dependencies: MovieListTableDataSourceDependencies
    private var movies = Movies()

    init(dependencies: MovieListTableDataSourceDependencies) {
        self.dependencies = dependencies
    }

    func search(for term: String) {
        dependencies.searchUseCase.query(for: term) { response in
            switch response {
            case let .success(movies):
                self.movies = movies
            case let .error(error):
                break
            }
        }
    }
}
