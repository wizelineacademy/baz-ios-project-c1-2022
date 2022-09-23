//
//  DataExample.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import Foundation
import UIKit

struct MovieModel {
    var movieObject = [
        TableViewMovieCellModel(
            sectionFilter: "Trending"
            ,posters: [
                        [
                            posterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,posterCollectionCell(posterImage: "square.and.arrow.down.fill", title: "Batman")
                            ,posterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,posterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        )/*,
        TableViewMovieCellModel(
            sectionFilter: "Now Playing"
            ,posters: [
                        [
                            posterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,posterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,posterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,posterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Popular"
            ,posters: [
                        [
                            posterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,posterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,posterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,posterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Top Rated "
            ,posters: [
                        [
                            posterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,posterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,posterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,posterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Upcoming"
            ,posters: [
                        [
                            posterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,posterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,posterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,posterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        )*/
    
    ]
}
