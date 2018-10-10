//
//  Poster.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct Poster: Equatable {
    public let path: String
    public let image: Data

    public init(path: String, image: Data) {
        self.path = path
        self.image = image
    }
}
