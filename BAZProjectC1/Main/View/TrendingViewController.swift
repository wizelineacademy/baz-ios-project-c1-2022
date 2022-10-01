//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    @IBOutlet weak var principalTabBar: UITabBarItem!
    private let movieAPI = MovieAPI()
    var viewModel = TrendingMovieViewModel()
    
    var postersMovieArray = MovieModel()
    var tappedCell: PosterCollectionCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
    }
    
    func setupView(){
        navigationItem.title = "Discover"
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: Bundle(for: TableViewCell.self)), forCellReuseIdentifier: "cell")
    }
    
    func getMovies(){
        self.view.showAnimation()
        viewModel.getMovies()
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.view.hideAnimation()
            }
        }
    }
    
}

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
}

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let object = viewModel.movieDataArray[indexPath.row]
        config.text = object.title
        let urlImage = "https://image.tmdb.org/t/p/w500\(object.posterPath)"
        if let url = URL(string: urlImage) {
            config.image = UIImage (url: url)
        } else {
            config.image = UIImage(named: "poster")
        }
        cell.contentConfiguration = config
    }

}
