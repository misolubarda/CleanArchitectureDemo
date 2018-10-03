//
//  MovieFake.swift
//  DataLayerTests
//
//  Created by Lubarda, Miso on 03.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

extension Movie {
    init() {
        self.init(posterPath: "posterPath", title: "title", release: Date(), overview: "overview")
    }
}
