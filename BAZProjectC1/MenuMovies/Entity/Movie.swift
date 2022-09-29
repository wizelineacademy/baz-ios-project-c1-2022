//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct MovieDay: Codable {
    let results: [Movie]
}

struct Movie: Codable{
    let id: Int?
    let media_type: String?
    let title: String?
    let poster_path: String?
    let vote_average: Double?
    let original_title: String?
}

public enum CategoryMovieType:String {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var endpoint: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
    
    var typeName: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

public enum ApiLanguageResponse:String, Codable{
    
    case es
    case en
    case de
    case pt
    
    var fullName: String {
        switch self {
        case .es:
            return "Español"
        case .en:
            return "English"
        case .de:
            return "Deutsch"
        case .pt:
            return "Português"
        }
    }
}
