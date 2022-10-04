//
//  SearchBarController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 03/10/22.
//

import Foundation
import UIKit

final class SearchBarController: UIViewController {
    @IBOutlet private var textField: UITextField!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var moviesSearch = SearchMovie(results: [MovieSearchData]())
    private var searching = MovieSearch()
    private var arregloFiltrados:[MovieSearchData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.dismissKeyboard()
    }
    
    private func configTable() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "tablecell")
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
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? customCellController else { return UITableViewCell() }
        if let imageMovie = arregloFiltrados[indexPath.row].posterPath, let _ = arregloFiltrados[indexPath.row].title {
            celda.imageMovie.downloaded(from: "https://image.tmdb.org/t/p/w500\(imageMovie)")
            celda.titleMovie.text = arregloFiltrados[indexPath.row].title
        }
        return celda
    }
    
}

extension SearchBarController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieDetailController else { return }
        vcMovieDetails.movieId = arregloFiltrados[indexPath.row].id
        vcMovieDetails.movieImageUrl = arregloFiltrados[indexPath.row].backdropPath
        vcMovieDetails.movieOverview = arregloFiltrados[indexPath.row].overview
        vcMovieDetails.movieTitle = arregloFiltrados[indexPath.row].title
        vcMovieDetails.movieRating = arregloFiltrados[indexPath.row].voteAverage
        self.navigationController?.pushViewController(vcMovieDetails, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension SearchBarController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arregloFiltrados = []
        
        if searchText.isEmpty {
            arregloFiltrados = []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
            }
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
