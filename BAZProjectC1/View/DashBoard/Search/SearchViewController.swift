//
//  SearchViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var queryTextField: UITextField!
    var querySearchString: String = ""
    var moviesList: [MovieModel] = [] {
        didSet{
            carouselMovies.setDataInfo(infoCarousel: moviesList)
        }
    }
    public lazy var carouselMovies: CarouselMovies = {
        let carouselMovies = CarouselMovies(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height * 0.55)))
        carouselMovies.translatesAutoresizingMaskIntoConstraints = false
        carouselMovies.delegate = self
        return carouselMovies
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configutionView()
    }
    
    func configutionView(){
        setupUI()
        view.backgroundColor = UIColor.appColorBlack
    }
    
    private func setupUI() {
        view.addSubview(carouselMovies)
        hideKeyboardWhenTappedAroundView()
        let ASPECT_RATION_SCREEN: CGFloat = view.frame.size.height / view.frame.size.width
        NSLayoutConstraint.activate([ carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                      carouselMovies.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
                                      carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: ASPECT_RATION_SCREEN)])
    }

    @IBAction func finishToTapping(_ sender: UITextField) {
        searchMovieFrom(with: queryTextField.getSearchQueryString())
    }
}
