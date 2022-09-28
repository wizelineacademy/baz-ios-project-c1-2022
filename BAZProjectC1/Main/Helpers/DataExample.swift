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
        TableViewMovieCellModel (
            sectionFilter: "Trending"
            ,posters: [
                        [
                            PosterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,PosterCollectionCell(posterImage: "square.and.arrow.down.fill", title: "Batman")
                            ,PosterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,PosterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        )
        ,
        TableViewMovieCellModel(
            sectionFilter: "Now Playing"
            ,posters: [
                        [
                            PosterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,PosterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,PosterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,PosterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Popular"
            ,posters: [
                        [
                            PosterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,PosterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,PosterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,PosterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Top Rated "
            ,posters: [
                        [
                            PosterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,PosterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,PosterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,PosterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        ),
        TableViewMovieCellModel(
            sectionFilter: "Upcoming"
            ,posters: [
                        [
                            PosterCollectionCell(posterImage: "img1.jpg", title: "Spiderman")
                            ,PosterCollectionCell(posterImage: "img2.jpg", title: "Batman")
                            ,PosterCollectionCell(posterImage: "img3.jpg", title: "Ant Man")
                            ,PosterCollectionCell(posterImage: "img4.jpg", title: "Ghost")
                        ]
                     ]
        )
    
    ]
}
