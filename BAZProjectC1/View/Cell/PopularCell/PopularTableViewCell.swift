//  PopularTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class PopularTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!

    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?

    
    //MARK: - F U N C T I O N S
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setGradientOnImage(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgPoster.frame.width, height: imgPoster.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgPoster.layer.insertSublayer(gradient, at: 0)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        self.setGradientOnImage()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func setPopularView(with obj:Movie){
        if let urlPoster = obj.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let dVote: Double = obj.voteAverage ?? 0.0
        self.lblTitle.text = obj.title
        self.lblOverview.text = obj.overview
        self.lblVote.text = String(format: "%.1f", dVote )
    }
    
}
