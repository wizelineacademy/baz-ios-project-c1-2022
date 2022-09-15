//
//  APIURLHandler.swift
//  BAZProjectC1
//
//  Created by 1030361 on 15/09/22.
//

import Foundation

public class APIURLHandler{
    func getURLContent(url: String) -> [NSDictionary] {
        
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        return results
    }
}
