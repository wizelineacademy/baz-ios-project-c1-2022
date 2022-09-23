//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    private var movies: [Movie] = []
    private let movieAPI = MovieAPI()
    var viewModel = TrendingMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getMovies()
        retrieveData()
        
    }
    
    func getMovies(){
        self.movieAPI.getMovies { [weak self] movies in
            self?.movies = movies
           DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
       }
    }
    
    func retrieveData(){
        viewModel.getMoviesMV()
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
}


// MARK: - TableView's DataSource

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieDataArray.count
//        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
}

// MARK: - TableView's Delegate

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let object = viewModel.movieDataArray[indexPath.row]
        
        config.text = object.title
        config.image = UIImage(named: "poster")
//        config.text = movies[indexPath.row].title
//        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
