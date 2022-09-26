//
//  MovieInformationController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 22/09/22.
//

import Foundation
import UIKit

final class MovieInformationController: UIViewController {
    
    @IBOutlet weak var movieTitile: UILabel!
    @IBOutlet weak var movieReview: UITextView!
    public var movies:[MovieData]?
    public var movieId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails()
    }
    
    /** Function that shows the details of the movie */
    private func showDetails() {
        movieReview.isEditable = false
        if let movies = movies, let movieid = movieId {
            if let title = movies[safe: movieid]?.title, let overview = movies[safe: movieid]?.overview {
                movieTitile.text = title
                movieReview.text = overview
            }
        }
    }
}
