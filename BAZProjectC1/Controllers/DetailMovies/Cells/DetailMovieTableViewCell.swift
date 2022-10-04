//
//  DetailMovieTableViewCell.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 02/10/22.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellDetail(movie: Movie){
        self.lblVoteAverage.text = "\(Int(movie.vote_average.rounded()))"
        self.lblTitle.text = movie.title
        self.lblDescription.text = movie.overview
    }
    
}
