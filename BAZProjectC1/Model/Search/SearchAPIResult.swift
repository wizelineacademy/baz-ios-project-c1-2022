//  SearchAPIResult.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import Foundation

struct SearchAPIResult : Codable {
    let page : Int?
    let search : [Search]?
    let totalPages : Int?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case search = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
