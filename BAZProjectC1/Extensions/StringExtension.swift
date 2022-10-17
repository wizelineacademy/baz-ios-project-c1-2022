//
//  StringExtension.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 03/10/22.
//

import Foundation

extension String {
    
    //MARK: - Computed Property
    var addSpacesForApi: String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
