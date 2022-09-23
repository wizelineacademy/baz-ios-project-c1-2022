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
        
        self.selectedCategoryPicker = category
        self.selectedLanguagePicker = language
        
        movieApi.getMovies(categoryMovieType: category, language: language) { response in
            self.movies = response
            DispatchQueue.main.async {
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
        
        self.title = "\(selectedCategoryPicker.typeName) Movies"

        collectionMovieMenu.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: Bundle(for: MovieItemCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        
        movieApi.getMovies(categoryMovieType: .trending, language: .es) { response in
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
        
        print("---------> \(selectedMovie)")
    }
}
