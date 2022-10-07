//
//  MovieCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImageView: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    private var movie: DetailMovie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func requiredSetupUI(movie: DetailMovie?) {
        guard movie != nil else {
            print("Error: Movie vacio")
            return
        }
        self.movie = movie
        self.titleLbl.text = self.movie?.title
        self.cardImageView.loadImage(urlStr: "\(ConstantsApi.urlBase)\(self.movie?.poster_path ?? "")")
        
    }
}
