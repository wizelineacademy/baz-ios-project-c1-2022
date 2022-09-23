//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie: Codable{
    let id: Int
    let title: String
    let poster_path: String
    let vote_average: Double
    let original_title: String
}
