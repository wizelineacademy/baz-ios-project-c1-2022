//  UpcomingAPIResponse.swift
//  BAZProjectC1
//  Created by 291732 on 22/09/22.

import Foundation

struct UpcomingAPIResponse: Codable {
    let dates : Dates?
    let page : Int?
    let upcoming : [Upcoming]?
    let totalPages : Int?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page = "page"
        case upcoming = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
