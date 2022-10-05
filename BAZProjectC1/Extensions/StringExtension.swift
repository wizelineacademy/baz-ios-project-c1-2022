//
//  StringExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func getSearchQueryString() -> String {
        guard let queryString = self.text else { return "" }
        let searchQuery = "\(EndpointsList.searchMulti.description)\(queryString.replacingOccurrences(of: " ", with: "%20"))"
        return searchQuery
    }
}
