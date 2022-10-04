//
//  InformationMovie.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 01/10/22.
//

import UIKit

final class InformationMovie: UICollectionViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReview: UITextView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        
    }
    
    func configView() {
        movieReview.isEditable = false
        movieImage.layer.cornerRadius = 10

    }
}
