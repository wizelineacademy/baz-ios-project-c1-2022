//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Results: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
}
