//
//  SearchMovie.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 03/10/22.
//

import Foundation

// MARK: - SearchMovie
struct SearchMovie: Codable {
    let results: [MovieSearchData]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - MovieSearchData
struct MovieSearchData: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let firstAirDate, name: String?
    let originalName: String?
    let gender: Int?
    let knownForDepartment, profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originalName = "original_name"
        case gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

