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
    let id: Int
    let title: String
    let posterPath, overview: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount:  Int
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
    }
}
