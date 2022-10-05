//
//  CarouselMenuDelegate.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//
import Foundation

protocol CarouselMenuDelegate: AnyObject {
    func carouselMenu(_ carouselMenu: CarouselMenu, didSelectOption option: IndexPath)
}
