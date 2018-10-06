//
//  PosterProvider.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol PosterProvider {
    func fetchPosters(with paths:[String], completion: @escaping (Response<Poster>) -> Void)
}
