//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
}

struct ResultsApi: Codable {
    let results: [Movie]
}
