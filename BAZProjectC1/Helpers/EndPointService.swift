//
//  EndPointService.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 29/09/22.
//

import Foundation

enum EndPoint: CaseIterable {
    static var allCases: [EndPoint] {
        return [.trendingMovie, .nowPlaying, .popular, .topRated, .upComming]
    }
    
    private static let urlBase = "https://api.themoviedb.org/3/"
    private static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private static let urlBaseImage: String = "https://image.tmdb.org/t/p/w500"
    
    case trendingMovie
    case nowPlaying
    case popular
    case topRated
    case upComming
    case search (text: String)
    case imageFromURL
    case searchById(id: Int)
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
        case .search(let text):
            return "search/multi?api_key=\(EndPoint.apiKey)&query=\(text)"
        case .imageFromURL:
            return EndPoint.urlBaseImage
        case .searchById(let id):
            return "movie/\(id)/?api_key=\(EndPoint.apiKey)&language=en-US"
        }
    }
    
    var requestFrom: URLRequest {
        switch self {
        case .trendingMovie, .nowPlaying, .popular, .topRated, .upComming, .search, .searchById:
            let url = URL(string: EndPoint.urlBase + string)!
            return URLRequest(url: url)
        case .imageFromURL:
            let url = URL(string: EndPoint.urlBaseImage)!
            return URLRequest( url: url)
            
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
        case .search:
            return ""
        case .imageFromURL:
            return ""
        case  .searchById:
            return ""
        }
    }
}
