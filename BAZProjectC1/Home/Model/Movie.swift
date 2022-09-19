//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

struct ResultsApi: Codable {
    let results: [Movie]
}
