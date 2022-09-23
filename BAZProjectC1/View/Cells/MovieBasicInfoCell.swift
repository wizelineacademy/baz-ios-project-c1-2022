//
//  MovieBasicInfoCell.swift
//  BAZProjectC1
//
//  Created by 1044336 on 17/09/22.
//

import UIKit

class MovieBasicInfoCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    static let  identifier = String(describing: MovieBasicInfoCell.self)
    static func nib() -> UINib {
        return UINib(nibName: String(describing: MovieBasicInfoCell.self),bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(dataCell: MovieModel) {
        movieTitle.text =  dataCell.title
        moviePoster.loadImageFromUrl(urlString: "\(EndpointsList.imageResorce.description)\(dataCell.poster_path)")
    }
    
}
