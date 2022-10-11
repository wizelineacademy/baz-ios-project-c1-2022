//
//  MoviesCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configMovie(movie: Movie){
        print(movie)
        self.lblName.text = movie.title
        self.lblVoteAverage.text = "\(Int(movie.vote_average.rounded()))"
        loadImg(img: movie.poster_path)
    }
    
    func loadImg(img: String){
        
        let urlImageName = "https://image.tmdb.org/t/p/w500\(img)"
        let urlString = urlImageName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else { return }
        
        UIImage.loadFrom(url: url) { image in
            if let image = image {
                
                UIView.transition(with: self.image,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image.image = image },
                                  completion: nil)
                
            } else {
                print("Image '\(String(describing: urlImageName))' does not exist!")
            }
            
        }
    }

}