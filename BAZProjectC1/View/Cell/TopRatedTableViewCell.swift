//  TopRatedTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class TopRatedTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UITextView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var sldRated: UISlider!

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
    
    private func setSlider(withValue val: Float) {
        sldRated.setThumbImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.white), for: .normal)
        sldRated.isContinuous = false
        sldRated.isEnabled = false
        sldRated.minimumTrackTintColor = .red
        sldRated.maximumTrackTintColor = .white
        sldRated.minimumValue = 0
        sldRated.maximumValue = 100
        sldRated.setValue(val, animated: true)
    }
    
    func setTopRated(with obj:TopRated) {
        if let urlPoster = obj.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            downloadTask = imgPoster.loadImage(url: url)
        }
        let dVote: Double = obj.voteAverage ?? 0.0
        self.lblTitle.text = obj.title
        self.lblDesc.text = obj.overview
        self.lblTotal.text = "Votos hasta ahora: \(obj.voteCount ?? 0)"
        self.lblAverage.text =  "Promedio de Votos: \(String(format: "%.1f", dVote))"
        self.setSlider(withValue: Float(obj.popularity ?? 0.0))
    }

}
