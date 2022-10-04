//
//  TypeMovie.swift
//  BAZProjectC1
//
//  Created by 1030361 on 04/10/22.
//

import Foundation

enum TypeMovie {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComing
    case searched(String)
    
    var url: MovieAPI {
        switch self {
        case .trending:
            return MovieAPI(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .nowPlaying:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .popular:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .topRated:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case .upComing:
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case let .searched(typed):
            return MovieAPI(url: "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&query=\(typed)")
        }
    }
}
