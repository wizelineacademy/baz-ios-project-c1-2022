//  TopRatedAPIResponse.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import Foundation

struct TopRatedAPIResponse: Codable {
    let page : Int?
    let results : [TopRated]?
    let totalPages : Int?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
