//
//  AppDependenciesContainer.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import DomainLayer

class AppDependenciesContainer: AppCoordinatorDependencies {
    var searchUseCase: MovieSearchUseCase = MovieSearchInteractor()
}
