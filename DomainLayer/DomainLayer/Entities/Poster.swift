//
//  Poster.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct Poster: Equatable {
    let path: String
    let image: Data

    public init(path: String, image: Data) {
        self.path = path
        self.image = image
    }
}
