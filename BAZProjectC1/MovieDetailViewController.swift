//
//  MovieDetailViewController.swift
//  BAZProjectC1
//
//  Created by 961184 on 23/09/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imgMovie: CachedImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var txvOverview: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionMovieRelated: UICollectionView!
    
    
    @IBOutlet weak var heightContentView: NSLayoutConstraint!
    private let urlBase = "https://image.tmdb.org/t/p/w500"
    
    var movieDetail: MovieDetail?
    var movies: [Movie] = []
    let movieApi = MovieAPI()
    
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant : CGFloat = 75
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow:Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = movieDetail?.title
        self.lblDetails.text = "\(movieDetail?.original_title ?? "") | \(movieDetail?.genres?.first?.name ?? "") | \(movieDetail?.release_date ?? "")\(movieDetail?.adult ?? false ? " | 18+": " | 18-")"
        self.txvOverview.text = movieDetail?.overview == nil || movieDetail?.overview == "" ? "Sin reseña" : movieDetail?.overview
        self.imgMovie.loadImage(urlStr: "\(urlBase)\(movieDetail?.poster_path ?? "")")
        collectionMovieRelated.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: Bundle(for: MovieItemCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        self.title = movieDetail?.title
        movieApi.getMovieSimilar(idMovie: self.movieDetail?.id ?? 0) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.collectionMovieRelated.delegate = self
                self.collectionMovieRelated.dataSource = self
                self.collectionMovieRelated.reloadData()
            }
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies.count > 6 {
            return 6
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets : CGFloat
        marginAndInsets = minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + insets * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth + heightAditionalConstant)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieItemCollectionViewCell", for: indexPath) as? MovieItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.requiredSetupUI(movie: self.movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.movies[indexPath.row]
        self.title = ""
        self.view.addSkeletonAnimation()
        movieApi.getMovieDetail(idMovie: selectedMovie.id ?? 0) { response in
            DispatchQueue.main.async {
                self.view.removeSkeletonAnimation()
//                self.title = "\(self.selectedCategoryPicker.typeName) Movies"
                let storyboard = UIStoryboard(name: "DetailMovieStoryboard", bundle: nil)
                let viewcontroller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
                viewcontroller?.movieDetail = response
                self.navigationController?.pushViewController(viewcontroller ?? UIViewController(), animated: true)
            }
        }
    }
}

