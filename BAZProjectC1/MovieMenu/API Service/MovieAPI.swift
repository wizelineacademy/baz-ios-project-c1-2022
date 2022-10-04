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
    
    func getMovies(completion: @escaping(_ response: [Movie], _ wasSucces: Bool) -> Void) {
        if let data = self.getDataFromURL(),
           let result = try? JSONDecoder().decode(MovieResults.self, from: data) {
            completion(result.results, true)
        } else {
            completion([], false)
        }
    }
}
