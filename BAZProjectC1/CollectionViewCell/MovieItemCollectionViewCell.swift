//
//  MovieItemCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 961184 on 21/09/22.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var subTitleLbl: UILabel!
    
    private var movie: Movie?
    private let urlBase = "https://image.tmdb.org/t/p/w500"
    
    /**
     Function that assigns value to the visual elements of the CollectionViewCell from an object of type Movie.
     
     - Parameters:
       - movie: Object of type Movie that contains the necessary parameters to show in the view.
     */
    func requiredSetupUI(movie: Movie?) {
        guard movie != nil else {
            print("Error: Movie vacio")
            return
        }
        self.movie = movie
        self.titleLbl.text = self.movie?.title
        self.subTitleLbl.text = "\(self.movie?.original_title ?? "")"
        self.cardImageView.loadImage(urlStr: "\(urlBase)\(self.movie?.poster_path ?? "")")

    }
}
