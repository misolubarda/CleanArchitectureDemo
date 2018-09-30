//
//  Response.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public enum Response<T> {
    case success(T)
    case error(Error)
}
