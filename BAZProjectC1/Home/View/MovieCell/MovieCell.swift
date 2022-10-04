//
//  MovieCellCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1054812 on 15/09/22.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    
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
    }
    
    public func setupDataCell(name: String, image: String) {
        self.nameMovie.text = name
        self.imgMovie.loadUrlImage(urlString: image)
    }
}
