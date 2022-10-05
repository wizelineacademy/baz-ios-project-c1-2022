//
//  ApiServiceRequest.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

public class ApiServiceRequest {
    public static func getService<T: Decodable>(urlService: String, structureType: T.Type, handler: @escaping(_ responseData: Any?) -> Void ) {
        guard let url = URL(string: urlService) else {
            handler(nil)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { dataResponse,serviceResponse,errorResponse in
            DispatchQueue.main.async {
                guard let data = dataResponse,
                      let objectResponse = decodeJsonDataTo(object: structureType,with: data) else {
                    handler(nil)
                    return
                }
                handler(objectResponse)
            }
        }).resume()
    }
    
    public static func decodeJsonDataTo<T: Decodable>(object structureType: T.Type, with infoData: Data ) -> Any? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(structureType, from: infoData)
    }
}
