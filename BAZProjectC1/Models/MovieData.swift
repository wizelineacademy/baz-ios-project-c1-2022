//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

/// This is a model of movie response
struct MovieData: Codable {
    let results: Movies?
}

/// This is a representation of the movie object
struct Movie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let title: String?
    let name: String?
    let original_language: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

typealias Movies = [Movie]
