//
//  FiltersMovies.swift
//  BAZProjectC1
//
//  Created by MayteLA on 20/09/22.
//

import UIKit

public enum FiltersMovies: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComing
    
    public var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComing:
            return "Up Coming"
        }
    }
    
    public var url: String {
        switch self {
        case .trending:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .nowPlaying:
            return "https://api.themoviedb.org/3/movie/now_playing?api_key="
        case .popular:
            return "https://api.themoviedb.org/3/movie/popular?api_key="
        case .topRated:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case .upComing:
            return "https://api.themoviedb.org/3/movie/upcoming?api_key="
        }
    }
    
    public  var image: String {
        switch self {
        case .trending:
            return "trending"
        case .nowPlaying:
            return "nowPlaying"
        case .popular:
            return "popular"
        case .topRated:
            return "topRated"
        case .upComing:
            return "upComing"
        }
    }
}
