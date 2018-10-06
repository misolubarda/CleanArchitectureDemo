//
//  TMDBMovieSearchProvider.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class TMDBMovieSearchProvider: MovieSearchProvider {
    private let service: WebService

    public convenience init() {
        self.init(service: WebServiceProvider(session: DataNetworkSession()))
    }

    init(service: WebService) {
        self.service = service
    }

    public func query(for term: String, completion: @escaping (Response<Movies>) -> Void) {
        guard let request = ApiRequest(endpoint: .search(term: term)).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }
        service.execute(request) { (response: Response<MovieSearchResponse>) in
            switch response {
            case let .success(searchResponse):
                completion(.success(searchResponse.results))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

struct MovieSearchResponse: Decodable {
    let results: Movies
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case release = "release_date"
        case overview

    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let posterPath = try? container.decode(String.self, forKey: .posterPath)
        let title = try container.decode(String.self, forKey: .title)
        let overview = try container.decode(String.self, forKey: .overview)

        let releaseString: String = try container.decode(String.self, forKey: .release)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = formatter.date(from: releaseString) else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.release, in: container, debugDescription: "Cannot convert string to date")
        }
        self.init(posterPath: posterPath, title: title, release: releaseDate, overview: overview)
    }
}
