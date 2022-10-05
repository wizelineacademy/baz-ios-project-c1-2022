//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

class TrendingViewController: UITableViewController {

    fileprivate var movies: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieBasicInfoCell.nib(), forCellReuseIdentifier: MovieBasicInfoCell.identifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataInfo(urlString: EndpointsList.movieAPI.description)
    }
    func getDataInfo(urlString: String) {
        ApiServiceRequest.getService(urlService: urlString, structureType: MovieApiResponseModel.self, handler: { [weak self] dataResponse in
            if let data = dataResponse as? MovieApiResponseModel {
                self?.reloadDataToTable(with: data)
            }
        })
    }
    func reloadDataToTable(with data: MovieApiResponseModel)  {
        self.movies = data.results
        self.tableView.reloadData()
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieBasicInfoCell.identifier, for: indexPath) as? MovieBasicInfoCell else { return UITableViewCell() }
        cell.configure(dataCell: movies[indexPath.row])
        return cell
    }

}
// MARK: - TableView's Delegate
extension TrendingViewController {
}
