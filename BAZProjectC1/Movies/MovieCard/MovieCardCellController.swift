//
//  MovieCardCellController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 20/09/22.
//

import UIKit

final class MovieCardCellController: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var mainView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    
    /** Function that configures the view */
    private func configView() {
        mainView.layer.cornerRadius = 10
        movieImage.layer.cornerRadius = 10
    }
    
}
