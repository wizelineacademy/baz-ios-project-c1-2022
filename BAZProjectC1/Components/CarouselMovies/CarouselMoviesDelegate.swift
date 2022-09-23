//
//  CarouselMoviesDelegate.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import Foundation
public protocol CarouselMoviesDelegate: AnyObject {
    func movieSelected(position:Int)
}
public protocol CarouselMoviesPositionDelegate: AnyObject {
    func getCurrentItem(index:IndexPath)
}
