//
//  SearchViewControllerExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//
import Foundation
import UIKit

extension SearchViewController {
    func searchMovieFrom(with urlString: String) {
        ApiServiceRequest.getService(urlService: urlString, structureType: MovieApiResponseModel.self, handler: { [weak self] dataResponse in
            if let data = dataResponse as? MovieApiResponseModel {
                self?.moviesList = data.results ?? []
            }
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension SearchViewController: CarouselMoviesDelegate{
    func movieSelected(position: Int) {
        let element = moviesList[position]

        if element.knownFor == nil {
            guard let movieFullDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ElementFullDetailViewController") as? ElementFullDetailViewController else { return }
            movieFullDetail.modalPresentationStyle = .overCurrentContext
            movieFullDetail.setElementData(with: element)
            self.present(movieFullDetail, animated: true, completion: nil)
        } else {
            guard let moviesListView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController,
                  let moviesList = element.knownFor else { return }
            moviesListView.setmoviesListArray(moviesListArray: moviesList)
            self.present(moviesListView, animated: true, completion: nil)
            
        }
        
        
        
        
    }
}
