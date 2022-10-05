//
//  MovieCollectionViewController.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//
import UIKit

class MovieCollectionViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionMovieC: UICollectionView!
    var movies: [DetailMovie] = []
    var moviesFiltered: [DetailMovie] = []
    let movieApi = MovieAPI()
    var searchActive : Bool = false
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated)
        self.title = ConstantsDetailMovies.titleCollection
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name("colorChanged"),object:nil)
        view.backgroundColor = .cyan
        
        searchBar.delegate = self
        
        collectionMovieC.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let movieApi = MovieAPI()
        movieApi.getMovies{[weak self] (result, error) in
            
            if let err = error {
                let alert = UIAlertController(title: "Mensaje", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                
            }else{
                self?.movies = result.results
                self?.moviesFiltered = result.results
                DispatchQueue.main.async {
                    self?.collectionMovieC.delegate = self
                    self?.collectionMovieC.dataSource = self
                    self?.collectionMovieC.reloadData()
                }
            }
        }
    }
}
extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ConstantsLayoutMovieCollection.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ConstantsLayoutMovieCollection.insets, left: ConstantsLayoutMovieCollection.insets, bottom: ConstantsLayoutMovieCollection.insets, right: ConstantsLayoutMovieCollection.insets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsLayoutMovieCollection.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsLayoutMovieCollection.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets : CGFloat
        marginAndInsets = ConstantsLayoutMovieCollection.minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + ConstantsLayoutMovieCollection.insets * CGFloat(ConstantsLayoutMovieCollection.cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(ConstantsLayoutMovieCollection.cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth + ConstantsLayoutMovieCollection.heightAditionalConstant)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.requiredSetupUI(movie: self.movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = movies[indexPath.row].title
        let overview = movies[indexPath.row].overview
        let poster_path = movies[indexPath.row].poster_path
        
        let storyboard = UIStoryboard(name: "DetailMovie", bundle: nil)
        DispatchQueue.main.async {
            
            if let pathVC = storyboard.instantiateViewController(withIdentifier: "DetailMoviesViewController") as? DetailMoviesViewController{
                pathVC.strTitle = title
                pathVC.strDetails = overview
                pathVC.strImgMoviePath = poster_path
                self.show(pathVC, sender:nil)
                
            }
        }
    }
}
extension MovieCollectionViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            movies = moviesFiltered
        }
        else {
            movies = moviesFiltered.filter({ (text) -> Bool in
                let tmp: NSString = text.title as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(movies.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.collectionMovieC.reloadData()
        }
        
    }
}
