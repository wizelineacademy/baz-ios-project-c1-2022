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
    let posterPath, overview: String
    let releaseDate: String
    let voteCount:  Int
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
    }
}
