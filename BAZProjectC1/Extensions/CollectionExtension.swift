//
//  CollectionExtension.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 26/09/22.
//

import Foundation

extension Collection {
    
    //MARK: - Method
    /** Returns the element at the specified index if it exists, otherwise nil. */
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
