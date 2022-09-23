//
//  Strings.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

enum EndpointsList:String  {
    case movieAPI = "movieAPI"
    case imageResorce = "imageResorce"
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"

    
    var description: String {
        switch self {
        case .movieAPI:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"endpointMovieAPI") as? String {
                return endpoint
            } else { return "" }
        case .imageResorce:
            return "https://image.tmdb.org/t/p/w500"
        case .trending:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"trending") as? String{
                return endpoint
            } else { return "" }
        case .nowPlaying:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"nowPlaying") as? String{
                return endpoint
            } else { return "" }
        case .popular:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"popular") as? String{
                return endpoint
            } else { return "" }
        case .topRated:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"topRated") as? String{
                return endpoint
            } else { return "" }
        case .upcoming:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"upcoming") as? String{
                return endpoint
            } else { return "" }
        }
    }
}
