//
//  EnumSection.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 29/09/22.
//

//import Foundation

enum EnumSection: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComming
    
    var sectionName: String {
        switch self {
        case .trending:
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
