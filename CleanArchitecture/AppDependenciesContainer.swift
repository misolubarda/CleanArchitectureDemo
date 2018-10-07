//
//  AppDependenciesContainer.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import DomainLayer
import DataLayer

class AppDependenciesContainer: AppCoordinatorDependencies {
    var searchUseCase: MovieSearchUseCase = MovieSearchInteractor(provider: TMDBMovieSearchProvider())
    var posterUseCase: PosterUseCase = PosterInteractor(provider: TMDBPosterProvider())
}
