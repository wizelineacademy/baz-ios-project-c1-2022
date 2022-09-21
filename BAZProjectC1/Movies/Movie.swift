//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation


// MARK: - Movie
struct Movie: Codable {
    let results: [MovieData]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct MovieData: Codable {
    let id: Int
    let title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}
