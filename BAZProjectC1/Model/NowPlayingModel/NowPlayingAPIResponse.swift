//  NowPlayingAPIResponse.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import Foundation

struct NowPlayingAPIResponse: Codable {
    let dates : Dates?
    let page : Int?
    let nowPlaying : [NowPlay]?
    let totalPages : Int?
    let totalResults : Int?

    /// CodingKey nos ayudara a manejar variables a nuestro gusto, sin romper el codable
    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page = "page"
        case nowPlaying = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


