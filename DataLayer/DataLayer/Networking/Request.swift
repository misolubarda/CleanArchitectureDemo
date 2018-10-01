//
//  Request.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 10/1/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct Request {
    let baseUrlString = "http://api.themoviedb.org/3"
    let authParameters = "?" + "api_key=2696829a81b1b5827d515ff121700838"
    let endpoint: Endpoint

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}
