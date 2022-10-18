//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

let tmdbImageStringURLPrefix = "https://image.tmdb.org/t/p/w500"
class TrendingViewController: UITableViewController {

    private var vmTrening = TrendingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Más populares"
        self.loadConfigureViewController()
        self.getMostPopularMovies()
    }
    
    private func loadConfigureViewController() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
    }
    
    private func getMostPopularMovies() {
        vmTrening.bindData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView's DataSource
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmTrening.getNumberOfItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else { return UITableViewCell() }
        cell.configureCellWithUrl(movieInfo: vmTrening.movie(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailViewController(with: indexPath.row)
    }
    
    func navigateToDetailViewController(with index: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.objMov = vmTrening.movie(at: index)
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}
