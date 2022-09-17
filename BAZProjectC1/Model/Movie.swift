//  Movie.swift
//  BAZProjectC1

import Foundation

struct Movie: Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?
}
