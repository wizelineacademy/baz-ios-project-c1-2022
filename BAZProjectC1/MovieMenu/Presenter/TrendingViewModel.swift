//
//  MainMenuPresenter.swift
//  BAZProjectC1
//
//  Created by 1030361 on 04/10/22.
//

import UIKit

class TrendingViewModel: NSObject {
    
    var movies: [Movie]
    var typeMovie: TypeMovie
    var imageArray: [UIImage]

    init(movies: [Movie], typeMovie: TypeMovie, imageArray: [UIImage]) {
        self.movies = movies
        self.typeMovie = typeMovie
        self.imageArray = imageArray
    }

}
