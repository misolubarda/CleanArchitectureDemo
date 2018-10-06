//
//  MovieFake.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

extension Movie {
    init(number: Int) {
        self.init(posterPath: "posterPath\(number)", title: "title\(number)", release: Date(), overview: "overview\(number)")
    }
}
