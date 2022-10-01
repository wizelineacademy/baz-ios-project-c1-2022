//
//  EndPointService.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 29/09/22.
//

import Foundation

enum EndPoint: CaseIterable {
    static let urlBase = "https://api.themoviedb.org/3/"
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    case trendingMovie
    case nowPlaying
    case popular
    case topRated
    case upComming
}

extension EndPoint {
    var string: String {
        switch self {
        case .trendingMovie:
            return "trending/movie/day?api_key=\(EndPoint.apiKey)"
        case .nowPlaying:
            return "movie/now_playing?api_key=\(EndPoint.apiKey)"
        case .popular:
            return "movie/popular?api_key=\(EndPoint.apiKey)"
        case .topRated:
            return "movie/top_rated?api_key=\(EndPoint.apiKey)"
        case .upComming:
            return "movie/upcoming?api_key=\(EndPoint.apiKey)"
        }
    }
    
    var requestFrom: URLRequest {
        switch self {
        case .trendingMovie, .nowPlaying, .popular, .topRated, .upComming:
            let url = URL(string: EndPoint.urlBase + string)!
            return URLRequest(url: url)
        }
    }
    
    var sectionName: String {
        switch self {
        case .trendingMovie:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComming:
            return "Up Comming"
        }
    }
}
