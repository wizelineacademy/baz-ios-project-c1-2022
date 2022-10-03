//
//  CategoryMovieTableDelegate.swift
//  BAZProjectC1
//
//  Created by 1029186 on 03/10/22.
//

import UIKit

class CategoryMovieTableDelegate: NSObject, UITableViewDelegate {

    var delegate: CategoryMovieCellProtocol

    init(using delegate: CategoryMovieCellProtocol) {
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectMovie(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        114.00
    }
}
