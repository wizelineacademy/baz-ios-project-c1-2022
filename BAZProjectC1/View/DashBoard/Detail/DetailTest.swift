//
//  DetailTest.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//
import UIKit

class DetailTest: UIViewController {
    
    private var elementData: MovieModel?
    
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var scrollArea: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameElement: UILabel!
    @IBOutlet weak var genreList: CarouselMenu!
    @IBOutlet weak var overviewMovie: UILabel!
    @IBOutlet weak var carouselCast: CarouselMovies!
    @IBOutlet weak var carouselSimilar: CarouselMovies!
    @IBOutlet weak var carouselRecomendations: CarouselMovies!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    func setUpView() {
        reloadDataInView()
        loadedAnimation()
    }
    
    func loadedAnimation() {
        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        UIView.animate(withDuration: 1.25, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity
        })
    }
    
    func setElementData(with elementData: MovieModel?) {
        self.elementData = elementData
    }
    
    @IBAction func goBack(_ sender: BackButton) {
        self.dismiss(animated: true, completion: nil)
    }
    private func reloadDataInView() {
        view.backgroundColor = UIColor.appColorBlack
        contentView.addSubview(nameElement)
        contentView.addSubview(genreList)
        genreList.backgroundColor = UIColor.clear
        genreList.configure(with: getConfigurationModel())
        contentView.backgroundColor = UIColor.appColorBlack
        posterImage.loadImage(with: elementData?.getMoviePosterString() ?? "")
        nameElement.text = elementData?.getMovieTitleString()
        nameElement.textColor = UIColor.appColorWhitePrimary
        overviewMovie.text = elementData?.overview
        getServiceInfo(from: "credits", with: CastApiResponseModel.self)
        getServiceInfo(from: "recommendations", with: MovieApiResponseModel.self)
        getServiceInfo(from: "similar", with: MovieApiResponseModel.self)
    }
    private func getConfigurationModel() -> CarouselMenuConfiguration {
        CarouselMenuConfiguration(frame: .zero,
                                  optionsTitles: elementData?.getGenresArray() ?? [] ,
                                  itemBackgroundColor: UIColor.appColorYellowPrimary,
                                  itemBorderBackgroundColor: UIColor.appColorYellowPrimary,
                                  itemSelectedBackgroundColor: UIColor.appColorYellowPrimary,
                                  itemSelectedBorderBackgroundColor: UIColor.appColorYellowPrimary)
    }
    
    private func getServiceInfo<T: Decodable>(from service: String, with structureType: T.Type) {
        let urlString = EndpointsList.getQuery(from: service, with: elementData?.id ?? 0)
        ApiServiceRequest.getService(urlService: urlString, structureType: structureType, handler: { [weak self] dataResponse in
            switch service {
            case "credits":
                guard let data = dataResponse as? CastApiResponseModel,
                      let arrayData = data.cast else { return }
                self?.carouselCast.setDataInfo(infoCarousel: arrayData)
            case "similar":
                guard let data = dataResponse as? MovieApiResponseModel,
                      let arrayData = data.results else { return }
                self?.carouselSimilar.setDataInfo(infoCarousel: arrayData)
            case "recommendations":
                guard let data = dataResponse as? MovieApiResponseModel,
                      let arrayData = data.results else { return }
                self?.carouselRecomendations.setDataInfo(infoCarousel: arrayData)
            default: break
            }
        })
    }
}
