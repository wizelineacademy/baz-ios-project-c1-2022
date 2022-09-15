//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiServiceRequest.getService(urlService: EndpointsList.movieAPI.description, structureType: MovieApiResponseModel.self, handler: {
            [weak self] dataResponse in
            if let data = dataResponse as? MovieApiResponseModel {
                DispatchQueue.main.async {
                    self?.movies = data.results
                    self?.tableView.reloadData()
                }
            }
        })
        
        
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

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }
    

}
