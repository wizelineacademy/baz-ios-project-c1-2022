//  TopRatedAPIResponse.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import Foundation

struct TopRatedAPIResponse: Codable {
    let page : Int?
    let topRateds : [TopRated]?
    let totalPages : Int?
    let totalResults : Int?

    /// CodingKey nos ayudara a manejar variables a nuestro gusto, sin romper el codable
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case topRateds = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
