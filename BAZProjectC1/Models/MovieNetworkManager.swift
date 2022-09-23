//
//  MovieManager.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//

import UIKit

final class MovieNetworkManager {

    // MARK: Operating variables -
    static let shared: MovieNetworkManager = MovieNetworkManager()
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let baseUrl: String = "https://api.themoviedb.org/3/"

    // MARK: Request methods -

    /// This method returns the list of movies of a specific genre
    /// - Parameters:
    ///   - genre: type of genre
    ///   - completionHandler: action when the consume to service finished
    func fetchMovies(genre: String, completionHandler: @escaping ((MovieData?, Error?) -> Void)) {
        var currentUrl: String?
        if genre == "trending" {
            currentUrl = "\(baseUrl)\(genre)/movie/day?api_key=\(apiKey)"
        } else {
            currentUrl = "\(baseUrl)movie/\(genre)?api_key=\(apiKey)"
        }
        guard let url = URL(string: currentUrl!) else {
            completionHandler(nil, NSError())
            return
        }
        executeRequest(request: url, completionHanlder: completionHandler)
    }

    /// This method download image from a url
    /// - Parameters:
    ///   - imagePath: path of the image
    ///   - width: the width of the image
    ///   - completionHanlder: action when the service response
    func downloadImage(imagePath: String, width: Int, completionHanlder: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w\(width)\(imagePath)?api_key=\(apiKey)") else {
            completionHanlder(nil)
            return
        }
        executeGeneralRequest(request: url) { data, _, _ in
            guard let data = data else {
                completionHanlder(nil)
                return
            }
            completionHanlder(UIImage(data: data))
        }
    }

    /// This method queries the service with URLSession with a custom model
    /// - Parameters:
    ///   - request: valid URLRequest
    ///   - completionHanlder: actions when the task finish
    private func executeRequest<T: Codable>(request: URL, completionHanlder: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHanlder?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completionHanlder?(decodedResponse, nil)
                }
            } else {
                completionHanlder?(nil, error)
            }
        }
        dataTask.resume()
    }


    /// This method do the query to the service and return a general response ready to be treated
    /// - Parameters:
    ///   - request: valid URLRequest
    ///   - completionHanlder: the action with info when the service response
    private func executeGeneralRequest(request: URL, completionHanlder: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: request, completionHandler: completionHanlder).resume()
    }
}
