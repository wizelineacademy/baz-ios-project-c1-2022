//
//  OptionMenuCellConfiguration.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//

import UIKit

struct OptionMenuCellConfiguration {
   let itemBackgroundColor: UIColor
   let itemBorderBackgroundColor: UIColor
   let itemBorder: Double
   let titleText: String
   let titleTextColor: UIColor

    init(itemBackgroundColor: UIColor = .clear,
          itemBorderBackgroundColor: UIColor = .clear,
          itemBorder: Double = 10.0,
          titleText: String = "") {
        self.itemBackgroundColor = itemBackgroundColor
        self.itemBorderBackgroundColor = itemBorderBackgroundColor
        self.itemBorder = itemBorder
        self.titleText = titleText
        if itemBackgroundColor == UIColor.appColorWhitePrimary {
            titleTextColor = .gray
        } else {
            titleTextColor = itemBackgroundColor
        }
    }
}
