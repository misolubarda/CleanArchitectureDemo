//
//  ImageRequest.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct ImageRequest {
    private let baseUrlString = "https://image.tmdb.org/t/p"
    private let imageSizePath = "w92"
    private let imagePath: String

    init(path: String) {
        imagePath = path
    }

    var urlRequest: URLRequest? {
        let urlString = baseUrlString + "/" + imageSizePath + "/" + imagePath
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}
