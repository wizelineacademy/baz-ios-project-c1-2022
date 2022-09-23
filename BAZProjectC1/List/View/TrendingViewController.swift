//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit
let strPathImage = "https://image.tmdb.org/t/p/w500"

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    let movieApi = MovieAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Más populares"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        movieApi.getMostPopular(completion: { lstInfo in
            self.movies = lstInfo
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
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
       
        var cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell
        if cell == nil {
            tableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell
        }
        cell?.configureCellWithUrl(movieInfo: movies[indexPath.row])
        return cell ?? UITableViewCell()
     
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.objMov = movies[indexPath.row]
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}
