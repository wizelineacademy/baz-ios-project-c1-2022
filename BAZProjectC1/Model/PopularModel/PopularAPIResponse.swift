//
//  PopularAPIResponse.swift
//  BAZProjectC1
//
//  Created by 291732 on 21/09/22.
//

import Foundation

struct PopularAPIResponse: Codable {
    let page : Int?
    let popular : [Popular]?
    let totalPages : Int?
    let totalResults : Int?
    
    /// CodingKey nos ayudara a manejar variables a nuestro gusto, sin romper el codable
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case popular = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
