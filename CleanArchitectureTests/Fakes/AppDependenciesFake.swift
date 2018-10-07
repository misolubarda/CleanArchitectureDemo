//
//  AppDependenciesFake.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

@testable import CleanArchitecture
import DomainLayer

class AppDependenciesFake: AppCoordinatorDependencies {
    var searchUseCase: MovieSearchUseCase = MovieSearchUseCaseFake()
    var posterUseCase: PosterUseCase = PosterUseCaseFake()
}
