//
//  MovieViewController+SearchBar.swift
//  BAZProjectC1
//
//  Created by rnunezi on 16/10/22.
//

import UIKit

//MARK: - MovieCollectionViewController + SearchBar

extension MovieCollectionViewController:UISearchBarDelegate{
    
    //  Method: Set the state of the search bar when the text did begin editing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchActive = true;
    }
    
    //  Method: Set the state of the search bar when the text did end editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    //  Method: Set the state of the search bar when the cancel button clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    //  Method: Set the state of the search bar when the search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    //  Method:  Filter searches by title
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            
            arrMoviesCollection = arrMoviesFiltered
        }
        else {
            
            arrMoviesCollection = arrMoviesFiltered.filter({ (text) -> Bool in
                let nsstrTitle: NSString = (text.title ?? "") as NSString
                let range = nsstrTitle.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(arrMoviesCollection.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.collectionMovieC.reloadData()
        }
        
    }
}
