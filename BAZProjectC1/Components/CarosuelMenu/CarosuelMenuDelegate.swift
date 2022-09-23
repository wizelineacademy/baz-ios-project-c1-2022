//
//  CarosuelMenuDelegate.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//
import Foundation

public protocol CarosuelMenuDelegate: AnyObject {
    
    func selectedOption(index: IndexPath)
}
