//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

/// This method send a request, for get url
/// - Parameters:
///   - requestUrl: URL path of an API
///   - completion: action when the service response
func moviesRequest (requestUrl: URLRequest, completion: @escaping (Data?, Error?) -> Void){
    let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
        completion(data, error)
    }
    task.resume()
}
