//
//  Movie.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct Movie: Equatable {
    public let posterPath: String
    public let title: String
    public let release: Date
    public let overview: String
}

public typealias Movies = [Movie]
