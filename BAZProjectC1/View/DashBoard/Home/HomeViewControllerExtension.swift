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
        guard let movieFullDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTest") as? DetailTest else { return }
        movieFullDetail.modalPresentationStyle = .overCurrentContext
        movieFullDetail.setElementData(with: moviesList[position])
        self.present(movieFullDetail, animated: true, completion: nil)
    }
}

extension HomeViewController: CarouselMenuDelegate{
    func carouselMenu(_ carouselMenu: CarouselMenu, didSelectOption option: IndexPath) {
        guard let UrlOptionSelected = EndpointsList(rawValue: filterDataArray[option.row])?.description else { return }
        getDataInfo(urlString: UrlOptionSelected)
    }
}
