//
//  MovieCardCellController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 20/09/22.
//

import UIKit

public protocol MovieCardProtocol: AnyObject {
    func clickEvent(movieId: Int)
}

final class MovieCardCellController: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var mainView: UIView!
    public weak var movieCardDelegate: MovieCardProtocol?
    public var idMovieCard: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if  (tapGestureRecognizer.view as? UIImageView) != nil {
            if let delegate = self.movieCardDelegate, let movieId = self.idMovieCard {
                delegate.clickEvent(movieId: movieId)
            }
        }
    }
    
    private func configView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(tapGestureRecognizer)
        mainView.layer.cornerRadius = 10
        movieImage.layer.cornerRadius = 10
    }
    
}
