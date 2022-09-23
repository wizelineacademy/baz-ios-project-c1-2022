//
//  HomeViewController.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    let filterDataArray = ["Trending","Now Playing","Popular","Top Rated","Upcoming"]
    var moviesList: [MovieModel] = []{
        didSet{
            carouselMovies.setDataInfo(infoCarousel: moviesList)
        }
    }
    
    
    public lazy var filterMenu: CarosuelMenu = {
        let filterMenuCGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        let filterMenu = CarosuelMenu(frame: filterMenuCGRect,
                                      optionsTitles: filterDataArray,
                                      itemBackgroundColor: UIColor.appColorYellowPrimary,
                                      itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                                      itemSelectedBackgroundColor: UIColor.appColorWhitePrimary,
                                      itemSelectedBorderBackgroundColor: UIColor.appColorGrayPrimary)
        filterMenu.translatesAutoresizingMaskIntoConstraints = false
        filterMenu.delegate = self
        return filterMenu
    }()
    
    public lazy var carouselMovies: CarouselMovies = {
        let carouselMovies = CarouselMovies(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height * 0.55)))
        carouselMovies.translatesAutoresizingMaskIntoConstraints = false
        carouselMovies.delegate = self
        return carouselMovies
    }()
    
    public lazy var basicInfoMovie: BasicInfoMovie = {
        let basicInfoMovieCGRect = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 100)
        let basicInfoMovie = BasicInfoMovie(frame: basicInfoMovieCGRect,viewBackgroundColor: UIColor.appColorYellowPrimary.withAlphaComponent(0.3))
        basicInfoMovie.translatesAutoresizingMaskIntoConstraints = false
        return basicInfoMovie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configutionView()
    }
    private func setupUI() {
        view.addSubview(filterMenu)
        view.addSubview(carouselMovies)
        view.addSubview(basicInfoMovie)

        filterMenu.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        filterMenu.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32).isActive = true
        
        carouselMovies.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        carouselMovies.topAnchor.constraint(equalTo: filterMenu.layoutMarginsGuide.bottomAnchor,constant: 24).isActive = true
        carouselMovies.heightAnchor.constraint(equalTo: carouselMovies.widthAnchor, multiplier: view.frame.size.height / view.frame.size.width).isActive = true
        
        basicInfoMovie.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        basicInfoMovie.topAnchor.constraint(equalTo: carouselMovies.layoutMarginsGuide.bottomAnchor,constant: 24).isActive = true
        basicInfoMovie.leftAnchor.constraint(equalTo: carouselMovies.layoutMarginsGuide.leftAnchor,constant: 16).isActive = true
        basicInfoMovie.rightAnchor.constraint(equalTo: carouselMovies.layoutMarginsGuide.rightAnchor,constant: -16).isActive = true

        basicInfoMovie.heightAnchor.constraint(equalTo: basicInfoMovie.widthAnchor, multiplier: view.frame.size.height / view.frame.size.width).isActive = true
       
    }
    func configutionView(){
        setupUI()
        view.backgroundColor = UIColor.appColorBlack
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let firstOption = filterDataArray.first,
              let UrlOptionSelected = EndpointsList(rawValue: firstOption)?.description else { return }
        getDataInfo(urlString: UrlOptionSelected)
    }
    func getDataInfo(urlString: String) {
        ApiServiceRequest.getService(urlService: urlString, structureType: MovieApiResponseModel.self, handler: {
                    [weak self] dataResponse in
                    if let data = dataResponse as? MovieApiResponseModel {
                        self?.moviesList = data.results ?? []
                    }
                })
    }
}
