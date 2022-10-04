//
//  HomeHeaderView.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit

class HomeHeaderView: UIView {

//    weak var homeViewController : MoviesViewController?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setImage(movie: Movie){
        
        self.lblTitle.text = movie.title
        self.lblText.text = movie.overview
        self.lblVoteAverage.text = "\(Int(movie.vote_average.rounded()))"
        
        let urlImageName = "https://image.tmdb.org/t/p/w500\(movie.poster_path)"
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
