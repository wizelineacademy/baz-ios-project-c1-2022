//
//  APIURLHandler.swift
//  BAZProjectC1
//
//  Created by 1030361 on 15/09/22.
//

import Foundation

protocol APIURLHandlerProtocol {
    var urlString: String { get set }
    func validateURL() -> URL?
    func getDataFromURL() -> Data?
}

internal class APIURLHandler: APIURLHandlerProtocol {
    var urlString: String
    
    init(url: String) {
        self.urlString = url
    }
    
    func validateURL() -> URL? {
        guard let url = URL(string: self.urlString) else { return nil }
        return url
    }
    
    func getDataFromURL() -> Data? {
        guard let url = validateURL(),
              let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
