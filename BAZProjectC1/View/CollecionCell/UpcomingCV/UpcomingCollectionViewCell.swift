//  UpcomingCollectionViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 30/09/22.

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    //MARK: - O U T L E T S
    @IBOutlet private weak var vwContainer: UIView!{
        didSet{
            self.vwContainer.layer.cornerRadius = 15
            self.vwContainer.layer.borderColor = .init(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
        }
    }
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgPoster: UIImageView!{
        didSet{ self.imgPoster.layer.cornerRadius = 15 }
    }
    //MARK: -  V A R I A B L E S
    private var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    /// Con esta funcion buscamos que la celda de la collecion pueda descargar e imprimir una imagen es Internet.
    internal func setCell(with upcoming:Upcoming?) {
        if let upcoming = upcoming {
            if let urlPoster = upcoming.posterPath , let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
                downloadTask = imgPoster.loadImage(url: url)
            }
            self.lblTitle.text = upcoming.title
        }
    }
}
