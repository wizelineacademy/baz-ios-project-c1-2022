//  DetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 06/10/22.

import UIKit

class DetailViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var cvRecomended: UICollectionView!{
        didSet{
            self.cvRecomended.delegate = self
            self.cvRecomended.dataSource = self
            self.cvRecomended.register(UINib(nibName: "ElementCollectionViewCell", bundle: .main),
                                       forCellWithReuseIdentifier: ElementCollectionViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var downloadTask: URLSessionDownloadTask?
    var movie: Movie?
    var objMovie: MovieAPIResponse?

    
    //MARK: - F U N C T I O N S
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInfo(with: movie)
        self.setGradientOnImage()
        self.setUpLeftMenu()
        self.getMovies(withId: movie?.id ?? 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setGradientOnImage(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgPoster.frame.width, height: imgPoster.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgPoster.layer.insertSublayer(gradient, at: 0)
    }

    func setInfo(with obj: Movie?){
        let dVote: Double = obj?.voteAverage ?? 0.0
        self.lblTitle.text = obj?.title
        self.lblDesc.text = obj?.overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblDate.text = obj?.releaseDate
        if let urlPoster = obj?.backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPoster.loadImage(url: url)
        }
    }
    
    //MARK: - S E R V I C E S
    private func getMovies(withId id:Int ) {
        let movieApi = MovieAPI()
        movieApi.getSimilar(withId: "\(id)") { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.cvRecomended.reloadData()
                }
            }
        }
    }
    
    @IBAction func goToRate(_ sender: Any) {
        let vc = RateViewController()
        vc.modalPresentationStyle = .automatic
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

//MARK: - EXT -> UI · C O L L E C T I O N · V I E W · D E L E G A T E S
extension DetailViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objMovie?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionViewCell.identifier, for: indexPath) as?  ElementCollectionViewCell ?? ElementCollectionViewCell()
        if let movie = objMovie?.movies?[indexPath.row] {
            cCell.setCell(with: movie)
        }
        return cCell
    }
}

//MARK: - EXT -> UI · C O L L E C T I O N · V I E W · D E L E G A T E S · F L O W · L A Y O U T
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 248)
    }
}
