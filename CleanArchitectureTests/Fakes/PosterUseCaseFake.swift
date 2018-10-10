//
//  PosterUseCaseFake.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 07.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import CleanArchitecture
import DomainLayer

class PosterUseCaseFake: PosterUseCase {
    var poster = Poster(path: "somePath", image: Data())
    var requestCount = 0
    var requestedPaths = [String]()

    func fetchPosters(with paths: [String], completion: @escaping (Response<Poster>) -> Void) {
        requestCount += 1
        requestedPaths = paths
        completion(.success(poster))
    }
}
