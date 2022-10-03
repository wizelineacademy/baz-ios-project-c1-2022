//
//  SearchBarController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 03/10/22.
//

import Foundation
import UIKit

class SearchBarController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    var moviesSearch = SearchMovie(results: [MovieSearchData]())
    var moviesSearch2 = Movie(results: [MovieData]())
    private var searching = MovieList()
    var arregloFiltrados:[MovieSearchData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        //arregloFiltrados = moviesSearch.results
    }
    func configTable() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    
    private func loadDataSimilar(keyword: String) {
        searching.loadMoviesSearch(with: keyword) { (movie) in
            self.moviesSearch = movie
            DispatchQueue.main.async {
                self.arregloFiltrados = self.moviesSearch.results
                self.tableView.reloadData()
            }
        }
    }
    
}


extension SearchBarController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
        celda.textLabel?.text = arregloFiltrados[indexPath.row].title
        return celda
    }
    
}

extension SearchBarController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieInformationController else { return }
        vcMovieDetails.movieId = arregloFiltrados[indexPath.row].id
        vcMovieDetails.movieImageUrl = arregloFiltrados[indexPath.row].backdropPath
        vcMovieDetails.movieOverview = arregloFiltrados[indexPath.row].overview
        vcMovieDetails.movieTitle = arregloFiltrados[indexPath.row].title
        vcMovieDetails.movieRating = arregloFiltrados[indexPath.row].voteCount
        self.navigationController?.pushViewController(vcMovieDetails, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

extension SearchBarController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arregloFiltrados = []
        
        if searchText.isEmpty {
            arregloFiltrados = []
        } else {
            loadDataSimilar(keyword: searchText.addSpacesForApi)
            for movie in moviesSearch.results {
                if let nameMovie = movie.title {
                    if nameMovie.lowercased().contains(searchText.lowercased()) {
                        arregloFiltrados.append(movie)
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
}
