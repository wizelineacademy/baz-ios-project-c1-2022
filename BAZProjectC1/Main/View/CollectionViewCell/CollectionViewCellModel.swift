//
//  CollectionViewCellModel.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import Foundation
import UIKit

// Modelo para mostrar los distintos filtros de las peliculas

struct posterCollectionCell {
    var posterImage: String
    var title: String
}


struct TableViewMovieCellModel {
    var sectionFilter: String
    var posters: [[posterCollectionCell]]
}
