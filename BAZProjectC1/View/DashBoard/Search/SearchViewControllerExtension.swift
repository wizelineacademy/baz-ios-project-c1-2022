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
}
extension SearchViewController: CarouselMoviesDelegate{
    func movieSelected(position: Int) {
//        guard let movieFullDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieFullDetailViewController") as? MovieFullDetailViewController else { return }
//        movieFullDetail.modalPresentationStyle = .overCurrentContext
//        movieFullDetail.item = moviesList[position]
//        self.present(movieFullDetail, animated: true, completion: nil)
    }
}
