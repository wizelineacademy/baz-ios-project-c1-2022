//  MovieTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 19/09/22.

import UIKit

final class MovieTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!{
        didSet{ self.vwContainer.layer.borderColor = .init(red: 117/255, green: 31/255, blue: 34/255, alpha: 1) }
    }
    @IBOutlet weak var imgPoster: UIImageView!{
        didSet{ self.imgPoster.layer.cornerRadius = 15 }
    }
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFormat: UILabel!
    
    
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
    
    override func prepareForReuse(){
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    public func setInfoTrading(with movie: Movie) {
        if let urlPoster = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let mediaT: String = (movie.mediaType == "movie") ? "Ahora en Cines" : "En Streaming"
        let dVote: Double = movie.voteAverage ?? 0.0
        self.lblTitle.text = movie.title
        self.lblOverview.text = movie.overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblDate.text = "Estreno: \(movie.releaseDate ?? "")"
        self.lblFormat.text = "\(mediaT) "
    }
}
