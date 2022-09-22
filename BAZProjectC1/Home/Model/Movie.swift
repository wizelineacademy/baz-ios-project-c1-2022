//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

struct ResultsApi: Codable {
    public let results: [Movie]
}
