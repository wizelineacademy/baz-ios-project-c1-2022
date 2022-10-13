//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation


enum MovieListType: String {
    case similar
    case recommendation
    case trending
    case popular
    case topRated
    case upcoming
    case nowPlaying
    
    var description: String {
        switch self {
        case .similar: return "similar"
        case .recommendation: return "recommendations"
        case .trending: return "trending"
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        case .nowPlaying: return "now_playing"
        }
    }
}

// MARK: - Movie
struct Movie: Codable {
    let results: [MovieData]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - MovieData
struct MovieData: Codable {
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
