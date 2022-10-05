//
//  Strings.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

enum EndpointsList: String  {
    case movieAPI = "movieAPI"
    case imageResource = "imageResource"
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case genreList = "genreList"
    case languagesList = "languagesList"
    case searchMulti = "searchMulti"
    
    var description: String {
        switch self {
        case .movieAPI:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "endpointMovieAPI") as? String else { return "" }
                return endpoint
        case .imageResource:
            return "https://image.tmdb.org/t/p/w500"
        case .trending:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "trending") as? String else { return "" }
                return endpoint
        case .nowPlaying:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "nowPlaying") as? String else { return "" }
                return endpoint
        case .popular:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "popular") as? String else { return "" }
                return endpoint
        case .topRated:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "topRated") as? String else { return "" }
                return endpoint
        case .upcoming:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "upcoming") as? String else { return "" }
                return endpoint
        case .genreList:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "genreList") as? String else { return "" }
                return endpoint
        case .languagesList:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "languagesList") as? String else { return "" }
                return endpoint
        case .searchMulti:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "searchMulti") as? String else { return "" }
                return endpoint
        }
    }
    static func getQuery(from service: String, with movieId: Int) -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String else { return "" }
        return "https://api.themoviedb.org/3/movie/\(movieId)/\(service)?api_key=\(apiKey)&language=es"
    }
}
