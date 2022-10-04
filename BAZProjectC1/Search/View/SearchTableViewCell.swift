//
//  SearchTableViewCell.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 30/09/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: SearchTableViewCell.self)
    
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var posterMovieImage: UIImageView!
    @IBOutlet private weak var rightImage: UIImageView!
    
    
    func setupCell(data: MovieData){
        self.movieTitleLabel.text = data.title
        self.posterMovieImage.downloaded(from: data.posterPath ?? "")
    }
    
}
