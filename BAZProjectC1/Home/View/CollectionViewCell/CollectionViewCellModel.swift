//
//  CollectionViewCellModel.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import Foundation
import UIKit

//Mark:- Model for distinct sections

struct TableViewMovieCellModel {
    var sectionFilter: String
    var posters: [[PosterCollectionCell]]
}

struct PosterCollectionCell {
    var posterImage: String
    var title: String
    var overView: String
}
