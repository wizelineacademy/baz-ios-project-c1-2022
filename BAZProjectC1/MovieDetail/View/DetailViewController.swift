//
//  DetailViewController.swift
//  BAZProjectC1
//
//  Created by 1054812 on 22/09/22.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    public var movie: Movie!
    private let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.titleMovie.text = movie.title
        self.descriptionMovie.text = movie.overview
        self.imageMovie.loadUrlImage(urlString: baseImageURL + movie.posterPath)
    }
}
