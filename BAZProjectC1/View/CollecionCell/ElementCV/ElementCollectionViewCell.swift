//  ElementCollectionViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

final class ElementCollectionViewCell: UICollectionViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSeeMore: UILabel!
    
    //MARK: -  V A R I A B L E S
    private var downloadTask: URLSessionDownloadTask?
    
    
    //MARK: - F U N C T I O N S
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    /// Con esta funcion buscamos que la celda de la collecion pueda descargar e imprimir una imagen es Internet.
    internal func setCell(with popular:Popular?) {
        if let popular = popular {
            if let urlPoster = popular.posterPath , let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
                downloadTask = imgPoster.loadImage(url: url)
            }
            self.lblTitle.text = popular.title
        }
    }
}
