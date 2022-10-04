//  ReviewAPIResponse.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import Foundation
struct ReviewAPIResponse : Codable {
    let id : Int?
    let page : Int?
    let review : [Review]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case review = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}
