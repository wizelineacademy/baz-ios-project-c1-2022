//
//  DetailMovie.swift
//  BAZProjectC1
//
//  Created by rnunezi on 13/10/22.
//

import Foundation

//Detail Movie Model

struct DetailMovie: Codable {
    
    public let id: Int?
    public let title: String?
    public let poster_path: String?
    public let overview: String?
}
