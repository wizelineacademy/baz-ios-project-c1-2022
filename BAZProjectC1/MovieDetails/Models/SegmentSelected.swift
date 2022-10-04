//
//  SegmentSelected.swift
//  BAZProjectC1
//
//  Created by 1030361 on 04/10/22.
//

import Foundation

enum SegmentSelected {
    case cast(Int)
    case reviews(Int)
    case similar(Int)
    case recommended(Int)
    
    var url: MovieAPI {
        switch self {
        case let .cast(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        case let .reviews(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        case let .similar(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        case let .recommended(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        }
    }
}
