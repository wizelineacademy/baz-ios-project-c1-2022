//
//  ApiServiceRequest.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

public class ApiServiceRequest{
    public static func getService<T: Codable>(urlService: String,structureType: T.Type, handler: @escaping(_ responseData: Any?) -> Void ) {
        guard let url = URL(string: urlService) else {
            handler(nil)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { dataResponse,serviceResponse,errorResponse in
            DispatchQueue.main.async {
                if let data = dataResponse {
                    do {
                        let objectResponse = try JSONDecoder().decode(structureType, from: data)
                        handler(objectResponse)
                    } catch {
                        handler(nil)
                    }
                }else {  handler(nil) }
            }
        }).resume()
    }
}
