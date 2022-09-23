//
//  MovieItemTableViewCell.swift
//  BAZProjectC1
//
//  Created by 961184 on 21/09/22.
//

import UIKit

class MovieItemTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImageView: CachedImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    private var movie: Movie?
    private let urlBase = "https://image.tmdb.org/t/p/w500"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func requiredSetupUI(movie: Movie?) {
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
