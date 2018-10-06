//
//  MovieSearchUseCaseFake.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

@testable import CleanArchitecture
import DomainLayer

class MovieSearchUseCaseFake: MovieSearchUseCase {
    var movies: Movies = []

    func query(for term: String, completion: @escaping (Response<Movies>) -> Void) {
        completion(.success(movies))
    }
}
