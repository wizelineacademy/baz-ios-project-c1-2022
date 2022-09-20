//  Movie.swift
//  BAZProjectC1

import Foundation

struct MovieAPIResponse: Codable {
    let page : Int?
    let movies : [Movie]?
    let totalPages : Int?
    let totalResults : Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
