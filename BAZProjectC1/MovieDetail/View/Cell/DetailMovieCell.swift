//
//  DetailCellCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Mayte LA on 03/10/22.
//

import UIKit

final class DetailMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var overviewMovie: UILabel!
    @IBOutlet weak var averageMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgMovie.layer.cornerRadius = 15
        self.imgMovie.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgMovie.image = nil
        self.nameMovie.text = nil
        self.overviewMovie.text = nil
        self.averageMovie.text = nil
    }
}
