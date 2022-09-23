//
//  MovieInformationController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 22/09/22.
//

import Foundation
import UIKit

final class MovieInformationController:UIViewController {
    
    @IBOutlet weak var movieTitile: UILabel!
    @IBOutlet weak var movieReview: UITextView!
    public var movies:[MovieData]?
    public var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        movieReview.isEditable = false
        if let movies = movies, let id = id {
            movieTitile.text = movies[id].title
            movieReview.text = movies[id].overview
        }

    }
}
