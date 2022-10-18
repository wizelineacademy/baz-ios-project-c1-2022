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
    private let urlBaseImage: EndPoint = .imageFromURL
    
    /// This method set a custom cell from data of MovieData type
    /// - Parameters:
    ///   - data: data of MovieData type.
    
    func setupCell(data: MovieData){
        self.movieTitleLabel.text = data.title
        self.posterMovieImage.downloaded(imagePath: "\(urlBaseImage.requestFrom)\(data.posterPath ?? "")")
    }
    
}
