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
    
    var description: String {
        switch self {
        case .movieAPI:
            guard let endpoint = Bundle.main.object(forInfoDictionaryKey:"endpointMovieAPI") as? String else { return "" }
            return endpoint
        case .imageResource:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}
