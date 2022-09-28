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
    public let overview: String
    public let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case rating = "vote_average"
    }
}

struct ResultsApi: Codable {
    public let results: [Movie]
}
