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
    public var movies:MovieData?
    public var movieId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails()
    }
    
    /** Function that shows the details of the movie */
    private func showDetails() {
        movieReview.isEditable = false
        if let movies = movies {
            movieTitile.text = movies.title
            movieReview.text = movies.overview
        }
    }
}
