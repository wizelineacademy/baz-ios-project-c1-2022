//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

internal struct MovieResults: Decodable {
    let results: [Movie]
}

internal struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}
