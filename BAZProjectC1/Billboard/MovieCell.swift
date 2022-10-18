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
    
    /**
     - parameters: movie model
     * this method loads the movie settings
     * assigns the values ​​to the controls inside the cell
     * view image by url to view
     */
    func configureCell(with movie: Movie? = nil) {
        lblTitle.text = movie?.title
        lblTitle.loadConfigurationFont(with: true)
        imgDetail.loadFrom(strUrl: movie?.imageDetail ?? "")
    }
    
    /**
     - parameters: movie model
     * this method loads the movie settings
     * assigns the values ​​to the controls inside the cell
     * view image by url to view
     */
    func configureCellUpdate(with movie: MovieUpdate? = nil) {
        lblTitle.text = movie?.title
        lblTitle.loadConfigurationFont(with: false)
        imgDetail.loadFrom(strUrl: movie?.imageDetail ?? "")
    }
}
