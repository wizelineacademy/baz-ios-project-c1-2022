//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [DetailMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieApi = MovieAPI()
        movieApi.getMovies{[weak self] (result, error) in
            if let err = error {
                let alert = UIAlertController(title: "Mensaje", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                
                }else{
                    self?.movies = result.results
                }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.title = "Peliculas"
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id = movies[indexPath.row].id
        var title = movies[indexPath.row].title
        var poster_path = movies[indexPath.row].poster_path
        let sb = UIStoryboard(name: "DetailMovie", bundle: nil)
        if let pathVC = sb.instantiateViewController(withIdentifier: "DetailMoviesViewController") as? DetailMoviesViewController{
            pathVC.strTitle = title
           
            self.navigationController?.popToViewController(pathVC, animated: true)
        }
    }
}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].poster_path)")
        if let data = try? Data(contentsOf: url!) {
            config.image = UIImage(data: data)
        } else {
            config.image = UIImage(named: "poster")
        }
        cell.contentConfiguration = config
    }

}
