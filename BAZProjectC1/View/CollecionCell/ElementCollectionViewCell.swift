//  ElementCollectionViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

class ElementCollectionViewCell: UICollectionViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSeeMore: UILabel!
    
    private var movie: Movie?
    private var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func setCell(with: Movie?) {
        guard movie != nil else { return }
        self.lblTitle.text = self.movie?.title
        if let urlPoster = movie?.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }

    }

}
