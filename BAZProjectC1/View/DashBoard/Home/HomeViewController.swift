//
//  HomeViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

fileprivate let PADDING_SCREEN_PIXEL: CGFloat = 16
fileprivate let IMAGE_CONSTANT_SIZE: CGFloat = 24

class HomeViewController: UIViewController {

    private var isTabHome: Bool = true
    let filterDataArray = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
    var moviesList: [MovieModel] = [] {
        didSet{
            carouselMovies.setDataInfo(infoCarousel: moviesList)
        }
    }
    
    public lazy var filterMenu: CarouselMenu = {
        let filterMenuCGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        let modelConfiguration = CarouselMenuConfiguration(frame: filterMenuCGRect,
                                                           optionsTitles: filterDataArray,
                                                           itemBackgroundColor: UIColor.appColorYellowPrimary,
                                                           itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                                                           itemSelectedBackgroundColor: UIColor.appColorWhitePrimary,
                                                           itemSelectedBorderBackgroundColor: UIColor.appColorGrayPrimary)
        
        let filterMenu = CarouselMenu(with: modelConfiguration)
        filterMenu.translatesAutoresizingMaskIntoConstraints = false
        filterMenu.delegate = self
        filterMenu.isHidden = true
        return filterMenu
    }()
    
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
    
    private func setupUI() {
        view.addSubview(filterMenu)
        view.addSubview(carouselMovies)
        let ASPECT_RATION_SCREEN: CGFloat = view.frame.size.height / view.frame.size.width
        NSLayoutConstraint.activate([filterMenu.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                     filterMenu.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: PADDING_SCREEN_PIXEL * 2),
                                     carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                                     carouselMovies.topAnchor.constraint(equalTo: filterMenu.layoutMarginsGuide.bottomAnchor,constant: IMAGE_CONSTANT_SIZE),
                                     carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: ASPECT_RATION_SCREEN)])
        
    }
    
    func configutionView() {
        setupUI()
        view.backgroundColor = UIColor.appColorGraySecondary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isTabHome {
            view.backgroundColor = UIColor.appColorBlack
            filterMenu.isHidden = false
            guard let firstOption = filterDataArray.first,
                  let UrlOptionSelected = EndpointsList(rawValue: firstOption)?.description else { return }
            getDataInfo(urlString: UrlOptionSelected)
        }
    }
     
    func getDataInfo(urlString: String) {
        ApiServiceRequest.getService(urlService: urlString, structureType: MovieApiResponseModel.self, handler: { [weak self] dataResponse in
            if let data = dataResponse as? MovieApiResponseModel {
                self?.moviesList = data.results ?? []
            }
        })
    }
    
    func setmoviesListArray(moviesListArray: [MovieModel]) {
        filterMenu.isHidden = true
        isTabHome = false
        moviesList = moviesListArray
    }
}
