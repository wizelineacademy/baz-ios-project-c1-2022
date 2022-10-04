//
//  CategoryMovieTableDataSource.swift
//  BAZProjectC1
//
//  Created by 1029186 on 03/10/22.
//

import UIKit

class CategoryMovieTableDataSource: NSObject, UITableViewDataSource {

    var movies: Movies?

    init(with movies: Movies) {
        self.movies = movies
    }

    func reloadData(with movies: Movies, using tableView: UITableView) {
        self.movies = movies
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movies?[indexPath.row] else {
            return UITableViewCell()
        }
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieCell", for: indexPath) as! CategoryMovieTableViewCell
        MovieNetworkManager.shared.downloadImage(imagePath: movie.poster_path ?? "", width: 200) { image in
            DispatchQueue.main.async {
                movieCell.setValuesMovie(posterImage: image, titleMovie: movie.title ?? movie.name)
            }
        }
        return movieCell
    }
}
