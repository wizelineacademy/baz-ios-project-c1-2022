//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie : Codable{
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let vote_average: Double
    let backdrop_path: String
}

struct ResponseMovie: Codable {
    var results: [Movie]
}
