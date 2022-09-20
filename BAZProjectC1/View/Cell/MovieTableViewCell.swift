//  MovieTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 19/09/22.

import UIKit

class MovieTableViewCell: UITableViewCell {
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
    @IBOutlet weak var btnSeeMore: UIButton!
    
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?
    
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
    
    public func setInfo(WithMovie movie: Movie, atIndex index:Int) {
        if let urlPoster = movie.results?[index].poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let mediaT: String = (movie.results?[index].media_type == "movie") ? "Ahora en Cines" : "En Streaming"
        let dVote: Double = movie.results?[index].vote_average ?? 0.0
        self.lblTitle.text = movie.results?[index].title
        self.lblOverview.text = movie.results?[index].overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblDate.text = "Estreno: \(movie.results?[index].release_date ?? "")"
        self.lblFormat.text = "\(mediaT) "
    }
    
}
