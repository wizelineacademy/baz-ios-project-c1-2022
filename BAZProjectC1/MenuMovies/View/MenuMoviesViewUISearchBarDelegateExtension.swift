//
//  MenuMoviesViewUISearchBarDelegateExtension.swift
//  BAZProjectC1
//
//  Created by 961184 on 01/10/22.
//

import UIKit

// MARK: - UISearchBarDelegate
extension MenuMoviesView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = .search
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            DispatchQueue.main.async {
                self.title = "\(self.presenter?.selectedCategory?.typeName ?? CategoryMovieType.trending.typeName) Movies"
                self.collectionMovieMenu.isUserInteractionEnabled = true
                self.collectionMovieMenu.reloadData()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchMovie = searchBar.text ?? ""
        searchMovie = searchMovie.folding(options: .diacriticInsensitive,
                                          locale: Locale.current).trimmingCharacters(in: .whitespaces)
        
        self.searchTerm = searchMovie
        
        if  !searchMovie.isEmpty {
            isSearching = true
            self.view.endEditing(true)
            presenter?.getSearchedMovies(searchTerm: self.searchTerm)
        }else{
            isSearching = false
            DispatchQueue.main.async {
                self.title = "\(self.presenter?.selectedCategory?.typeName ?? CategoryMovieType.trending.typeName) Movies"
                self.collectionMovieMenu.isUserInteractionEnabled = true
                self.collectionMovieMenu.reloadData()
            }
        }
    }
}
