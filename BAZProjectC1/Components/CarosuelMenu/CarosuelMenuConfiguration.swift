//
//  CarouselMenuConfiguration.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//

import UIKit

struct CarouselMenuConfiguration {
    let frame: CGRect
    let optionsTitles: [String]
    let itemBackgroundColor: UIColor
    let itemBorderBackgroundColor: UIColor
    let itemSelectedBackgroundColor: UIColor
    let itemSelectedBorderBackgroundColor: UIColor
    let itemBorder: Double
    
    init(frame:CGRect,
         optionsTitles:[String] = [],
         itemBackgroundColor: UIColor = .clear,
         itemBorderBackgroundColor: UIColor = .clear,
         itemSelectedBackgroundColor: UIColor = .clear,
         itemSelectedBorderBackgroundColor: UIColor = .clear,
         itemBorder: Double = 10.0) {
        
        self.frame = frame
        self.optionsTitles = optionsTitles
        self.itemBackgroundColor = itemBackgroundColor
        self.itemBorderBackgroundColor = itemBorderBackgroundColor
        self.itemSelectedBackgroundColor = itemSelectedBackgroundColor
        self.itemSelectedBorderBackgroundColor = itemSelectedBorderBackgroundColor
        self.itemBorder = itemBorder
    }
}
