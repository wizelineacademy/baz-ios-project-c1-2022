//
//  MovieCell.swift
//  BAZProjectC1
//
//  Created by efloresco on 21/09/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with movie: Movie) {
        lblTitle.text = movie.title
        lblTitle.loadConfigurationFont(with: true)
        imgDetail.loadFrom(strUrl: movie.imageDetail)
    }
    func configureCellUpdate(with movie: MovieUpdate) {
        lblTitle.text = movie.title
        lblTitle.loadConfigurationFont(with: false)
        imgDetail.loadFrom(strUrl: movie.imageDetail)
    }
}
