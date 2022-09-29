//
//  MovieMenuViewController.swift
//  BAZProjectC1
//
//  Created by 961184 on 22/09/22.
//

import UIKit

protocol SelectedFilterProtocol: AnyObject {
    func addFilterToMovies(category:CategoryMovieType, language:ApiLanguageResponse)
    func closeFiltersMovieModal()
}


class MovieMenuViewController: UIViewController, SelectedFilterProtocol{
    func closeFiltersMovieModal() {
        self.btnAddFilters.setBackgroundImage(.init(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
    }
    
    func addFilterToMovies(category: CategoryMovieType, language: ApiLanguageResponse) {
        self.title = "\(category.typeName) Movies"
        self.view.endEditing(true)
        
        self.selectedCategoryPicker = category
        self.selectedLanguagePicker = language
        
        movieApi.getMovies(categoryMovieType: category) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.isSearching = false
                self.collectionMovieMenu.delegate = self
                self.collectionMovieMenu.dataSource = self
                self.collectionMovieMenu.reloadData()
            }
        }
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFilters: UIButton!
    @IBOutlet weak var collectionMovieMenu: UICollectionView!
    
    var movies: [Movie] = []
    var searchResult: [Movie] = []
    var isSearching:Bool = false
    
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant : CGFloat = 45
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow:Int = 2
    let movieApi = MovieAPI()
    
    private var selectedCategoryPicker: CategoryMovieType = .trending
    private var selectedLanguagePicker: ApiLanguageResponse = .es

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.title = "\(selectedCategoryPicker.typeName) Movies"
        
        hideKeyboardWhenTappedAround()
        collectionMovieMenu.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: Bundle(for: MovieItemCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        
        movieApi.getMovies(categoryMovieType: .trending) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.collectionMovieMenu.delegate = self
                self.collectionMovieMenu.dataSource = self
                self.collectionMovieMenu.reloadData()
            }
        }
    }
    
    @IBAction func addFilter(_ sender: Any) {
        self.btnAddFilters.setBackgroundImage(.init(systemName: "line.horizontal.3.decrease.circle.fill"), for: .normal)
        let filterModalController = FiltersMovieModalViewController.requiredSetupUI(delegateSelectedFilter: self, initCategorySelected: selectedCategoryPicker, initLanguageSelected: selectedLanguagePicker)
        self.present(filterModalController ?? UIViewController(), animated: true, completion: nil)
    }

}

extension MovieMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchResult.count : movies.count
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
        cell.requiredSetupUI(movie: self.isSearching ? self.searchResult[indexPath.row] : self.movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.isSearching ? self.searchResult[indexPath.row] : self.movies[indexPath.row]
        self.title = ""
        self.view.addSkeletonAnimation()
        movieApi.getMovieDetail(idMovie: selectedMovie.id ?? 0) { response in
            DispatchQueue.main.async {
                self.view.removeSkeletonAnimation()
                self.title = "\(self.selectedCategoryPicker.typeName) Movies"
                let storyboard = UIStoryboard(name: "DetailMovieStoryboard", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
                viewController?.movieDetail = response
                self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
            }
        }
    }
}

extension MovieMenuViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = .search
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            searchResult.removeAll()
            DispatchQueue.main.async {
                self.title = "\(self.selectedCategoryPicker.typeName) Movies"
                self.collectionMovieMenu.isUserInteractionEnabled = true
                self.collectionMovieMenu.reloadData()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchMovie = searchBar.text ?? ""
        searchMovie = searchMovie.folding(options: .diacriticInsensitive,
                                          locale: Locale.current).trimmingCharacters(in: .whitespaces)
        
        if  !searchMovie.isEmpty {
            self.view.endEditing(true)
            self.movieApi.searchMovie(searchTerm: searchMovie) { response in
                self.isSearching = true
                DispatchQueue.main.async { self.title = searchMovie }
                if response.count > 0 {
                    self.searchResult = response
                    DispatchQueue.main.async {
                        self.collectionMovieMenu.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        self.collectionMovieMenu.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sin Resultados", message: "La búsqueda realizada no encontro ninguna coincidencia.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { UIAlertAction in
                            self.searchBar.text = ""
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }else{
            isSearching = false
            searchResult.removeAll()
            DispatchQueue.main.async {
                self.collectionMovieMenu.isUserInteractionEnabled = true
                self.collectionMovieMenu.reloadData()
            }
        }
    }
}

extension UIViewController{
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
