//
//  StringExtension.swift
//  BAZProjectC1
//
//  Created by 1029186 on 01/10/22.
//

import Foundation

extension String {

    /// This line return only the year of a date on format String
    var getYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let currentDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "y"
            return dateFormatter.string(from: currentDate)
        }
        return "yyyy"
    }

    /// This func replace and prepare the string for url request
    /// - Parameter character: replace character
    /// - Returns: the clean string
    func formatURL(_ character: String) -> String {
        self.replacingOccurrences(of: " ", with: character)
    }
}
