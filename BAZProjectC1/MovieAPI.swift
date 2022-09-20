//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

internal final class MovieAPI: APIURLHandler {
    override init(url: String) {
        super.init(url: url)
    }
    
    func getMovies() -> [Movie] {
        guard let data = self.getDataFromURL() else { return [] }
        let result = try! JSONDecoder().decode(MovieResults.self, from: data)
        return result.results
    }

}
