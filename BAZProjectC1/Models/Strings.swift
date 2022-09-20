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
    
    var description: String {
        switch self {
        case .movieAPI:
            if let endpoint = Bundle.main.object(forInfoDictionaryKey:"endpointMovieAPI") as? String{
                return endpoint
            }else{ return ""}
        case .imageResorce:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}
