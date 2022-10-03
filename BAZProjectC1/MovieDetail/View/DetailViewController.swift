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
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.titleMovie.text = movie.title ?? "No title"
        self.descriptionMovie.text = movie.overview
        
        self.imageMovie.loadUrlImage(urlString: ("\(GenericApiCall.baseImageURL)\(movie.posterPath ?? "")"))
    }
}
