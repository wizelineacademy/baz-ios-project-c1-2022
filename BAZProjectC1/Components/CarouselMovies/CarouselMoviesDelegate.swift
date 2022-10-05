//
//  CarouselMoviesDelegate.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import Foundation

internal protocol CarouselMoviesDelegate: AnyObject {
    func movieSelected(position:Int)
}
internal protocol CarouselMoviesPositionDelegate: AnyObject {
    func getCurrentItem(index:IndexPath)
}
