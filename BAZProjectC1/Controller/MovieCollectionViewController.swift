//
//  MovieCollectionViewController.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//
import UIKit

//MARK: - MovieCollectionViewController

class MovieCollectionViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionMovieC: UICollectionView!
    var arrMoviesAPI: [DetailMovie] = []
    var arrMoviesCollection: [DetailMovie] = []
    var arrMovies: [DetailMovie] = []
    var arrMoviesFavorites: [DetailMovie] = []
    var arrMoviesFiltered: [DetailMovie] = []
    let movieApi = MovieAPI()
    var searchActive : Bool = false
    var delegateMovies: FavoriteMovieCollectionProtocol?
    var delegateNavigator: UINavigationControllerDelegate?
    var delegateTab: UITabBarDelegate?
    var isMovieOriginal:Bool = false
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated)
        self.title = ConstantsDetailMovies.titleCollection
        isMovieOriginal = true
        setDataCollection()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name("colorChanged"),object:nil)
        view.backgroundColor = .cyan
        searchBar.delegate = self
        delegateMovies = self
        collectionMovieC.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        executeServiceMovies()
        
    }
    
// Method: Set Data Collection movies or favorites movies
    func setDataCollection(){
        
        if isMovieOriginal {
            self.arrMoviesFavorites.removeAll()
            self.arrMovies.removeAll()
            arrMoviesAPI.forEach{ (movies) in
                
                if (UserDefaults.standard.string(forKey: "\(movies.id ?? 0)") != nil) {
                    arrMoviesFavorites.append(movies)
                }else{
                    self.arrMovies.append(movies)
                }
            }
            arrMoviesCollection = arrMovies
            arrMoviesFiltered = arrMovies
            self.collectionMovieC.delegate = self
            self.collectionMovieC.dataSource = self
            self.collectionMovieC.reloadData()
            
        }
        else {
            self.executeServiceMoviesFavorites()
            
        }
    }
    
// Method: Query movie service
    func executeServiceMovies(){
        
        let movieApi = MovieAPI()
        movieApi.getMovies{[weak self] (result, error) in
            
            if let err = error {
                let alertView = UIAlertController(title: "Mensaje", message: err.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Aceptar", style:.default, handler: { (alert) in
                    print("Aceptar")
                })
                
                alertView.addAction(cancelAction)
                self?.present(alertView, animated: true, completion: nil)
                
            }else{
                self?.arrMoviesAPI = result.results ?? []
                self?.arrMoviesCollection = result.results ?? []
                self?.arrMoviesFiltered = result.results ?? []
                DispatchQueue.main.async {
                    self?.collectionMovieC.delegate = self
                    self?.collectionMovieC.dataSource = self
                    self?.collectionMovieC.reloadData()
                }
            }
        }
    }
  
// Method: Query movie favorites service
    func executeServiceMoviesFavorites(){
        
        let movieApi = MovieAPI()
        movieApi.getMovies{[weak self] (result, error) in
            
            if let err = error {
                let alertView = UIAlertController(title: "Mensaje", message: err.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Aceptar", style:.default, handler: { (alert) in
                    print("Aceptar")
                })
                
                alertView.addAction(cancelAction)
                self?.present(alertView, animated: true, completion: nil)
                
            }
            else{
                self?.arrMoviesFavorites.removeAll()
                self?.arrMovies.removeAll()
                
                self?.arrMoviesAPI = result.results ?? []
                self?.arrMoviesAPI.forEach{ (movies) in
                    
                    if (UserDefaults.standard.string(forKey:"\(movies.id ?? 0)") != nil) {
                        self?.arrMoviesFavorites.append(movies)
                    }else{
                        self?.arrMovies.append(movies)
                    }
                }
                self?.arrMoviesCollection = self?.arrMoviesFavorites ?? []
                self?.arrMoviesFiltered = self?.arrMoviesFavorites ?? []
                
                DispatchQueue.main.async {
                    self?.collectionMovieC.delegate = self
                    self?.collectionMovieC.dataSource = self
                    self?.collectionMovieC.reloadData()
                }
            }
        }
    }
    
// Method: Set Navigation to Detail Movie
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewControllerDestination = segue.destination as? DetailMoviesViewController {
            
            viewControllerDestination.detailMovie = sender as? DetailMovie
            viewControllerDestination.delegateMovies = self.delegateMovies
            viewControllerDestination.isMovieOriginal = self.isMovieOriginal
        }
    }
}

//MARK: - MovieCollectionViewController + FavoriteMovieCollectionProtocol
extension MovieCollectionViewController:FavoriteMovieCollectionProtocol{

// Method: remove Favorite Movies
    func removeFavoriteMovies(_ detailMovie: DetailMovie?) {
        
        UserDefaults.standard.removeObject(forKey: "\(detailMovie?.id ?? 0)")
        UserDefaults.standard.synchronize()
    }
 
// Method: add Favorite Movies
    func addFavoriteMovies(_ detailMovie: DetailMovie?) {
        
        UserDefaults.standard.set(detailMovie?.title ?? "", forKey:"\(detailMovie?.id ?? 0)")
        UserDefaults.standard.synchronize()
    }
}
