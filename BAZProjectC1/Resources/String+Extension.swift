//
//  String+Extension.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//

import Foundation

extension String {
    static func localized(_ key: String) -> String{
        let string = Bundle.main.localizedString(forKey: key, value: nil, table: "Localizable")
        return string
    }
}
