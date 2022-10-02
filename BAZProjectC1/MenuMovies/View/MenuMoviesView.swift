//
//  MenuMoviesView.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class MenuMoviesView: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var btnAddFilters: UIButton!
    @IBOutlet weak var collectionMovieMenu: UICollectionView!
    
    // MARK: - Properties
    var presenter: MenuMoviesPresenterProtocol?
    var isSearching:Bool = false
    var searchTerm:String = ""
    
    // MARK: - Properties of collectionMovieMenu configuration
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant : CGFloat = 45
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow:Int = 2

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.title = "\(self.presenter?.selectedCategory?.typeName ?? CategoryMovieType.trending.typeName) Movies"
        self.presenter?.viewDidLoad()
        hideKeyboardWhenTappedAround()
        collectionMovieMenu.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: Bundle(for: MovieItemCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        
    }
    
    /**
     Function that shows the filter selection view
     
     - Parameters:
        - sender: Object who sends or transmits the acction occurred in the button.
     */
    @IBAction func addFilter(_ sender: Any) {
        self.btnAddFilters.setBackgroundImage(.init(systemName: "line.horizontal.3.decrease.circle.fill"), for: .normal)
        let filterModalController = FiltersMovieModalViewController.requiredSetupUI(delegateSelectedFilter: self, initCategorySelected: self.presenter?.selectedCategory, initLanguageSelected: self.presenter?.selectedLanguage)
        self.present(filterModalController ?? UIViewController(), animated: true, completion: nil)
    }
}

// MARK: - MenuMoviesViewProtocol
extension MenuMoviesView: MenuMoviesViewProtocol {
    
    /**
     Function that reloads the collectionMovieMenu and assigns his delegates.
     */
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionMovieMenu.delegate = self
            self.collectionMovieMenu.dataSource = self
            self.collectionMovieMenu.reloadData()
        }
    }
    
    /**
     Function that reloads the CollectionView when searching for a movie.
     */
    func reloadCollectionViewSearchedData() {
        self.isSearching = true
        DispatchQueue.main.async { self.title = self.searchTerm }
        if presenter?.getSearchedMovieCount() ?? 0 > 0 {
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
    
    /**
     Function that removes the loading animation and shows an alert in case of an error ocurred in the api response.
     */
    func catchResponse(withMessage: String?) {
        DispatchQueue.main.async {
            self.view.removeSkeletonAnimation()
            self.title = "\(self.presenter?.selectedCategory?.typeName ?? CategoryMovieType.trending.typeName) Movies"
            if let message = withMessage, message != "" {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - Protocol definition SelectedFilterProtocol
protocol SelectedFilterProtocol: AnyObject {
    func addFilterToMovies(category:CategoryMovieType, language:ApiLanguageResponse)
    func closeFiltersMovieModal()
}

// MARK: - SelectedFilterProtocol
extension MenuMoviesView: SelectedFilterProtocol {
    // MARK: - SelectedFilterProtocol functions
    /**
     Function that set BackgroundImage to btnAddFilters when the filters view is closed.
     */
    func closeFiltersMovieModal() {
        self.btnAddFilters.setBackgroundImage(.init(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
    }
    
    /**
     Function that set selectedCategory and selectedLanguage from presenter to next call de viewDidLoad function.
     */
    func addFilterToMovies(category: CategoryMovieType, language: ApiLanguageResponse) {
        self.title = "\(category.typeName) Movies"
        self.view.endEditing(true)
        
        self.presenter?.selectedCategory = category
        self.presenter?.selectedLanguage = language
        self.presenter?.viewDidLoad()
    }
}
