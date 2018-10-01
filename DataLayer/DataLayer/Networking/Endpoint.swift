//
//  Endpoint.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

enum Endpoint {
    case search(term: String)

    var path: String {
        switch self {
        case .search:
            return "search/movie"
        }
    }

    var parameters: String {
        switch self {
        case let .search(term: term):
            return "&query=\(term)"
        }
    }
}
