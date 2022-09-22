//  NowPlayingTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class NowPlayingTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!{
        didSet{
            self.vwContainer.layer.borderColor = .init(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
        }
    }
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?
    private let wzlnDarkBlue: UIColor = UIColor(red: 12, green: 24, blue: 35, alpha: 1)
    private let wzlnMediumBlue: UIColor = UIColor(red: 32, green: 52, blue: 73, alpha: 1)
    
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
    
    public func setInfo(with nowPlay: NowPlay) {
        if let urlPoster = nowPlay.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)") {
            downloadTask = imgPoster.loadImage(url: url)
        }
        let dVote: Double = nowPlay.voteAverage ?? 0.0
        self.lblTitle.text = nowPlay.title
        self.lblOriginalTitle.text = nowPlay.originalTitle
        self.lblOverview.text = nowPlay.overview
        self.lblVote.text = String(format: "%.1f", dVote )
    }

}
