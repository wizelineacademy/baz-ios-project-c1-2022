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
        print(position)
    }
}

extension HomeViewController: CarosuelMenuDelegate{
    func selectedOption(index: IndexPath) {
        guard let UrlOptionSelected = EndpointsList(rawValue: filterDataArray[index.row])?.description else { return }
        getDataInfo(urlString: UrlOptionSelected)
    }
}
