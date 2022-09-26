//
//  HomeViewControllerExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import Foundation
import UIKit

extension HomeViewController: CarouselMoviesDelegate{
    
    func movieSelected(position: Int) {
        print(moviesList[position].title)
        guard let movieFullDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieFullDetailViewController") as? MovieFullDetailViewController else { return }
        movieFullDetail.modalPresentationStyle = .overCurrentContext
        self.present(movieFullDetail, animated: true, completion: nil)
    }
}
extension HomeViewController: CarosuelMenuDelegate{
    
    func selectedOption(index: IndexPath) {
        guard let UrlOptionSelected = EndpointsList(rawValue: filterDataArray[index.row])?.description else { return }
        getDataInfo(urlString: UrlOptionSelected)
    }
}

