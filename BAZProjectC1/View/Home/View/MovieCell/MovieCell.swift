//
//  MovieCellCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1054812 on 15/09/22.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgMovie.layer.cornerRadius = 15
        self.imgMovie.clipsToBounds = true
    }

}
