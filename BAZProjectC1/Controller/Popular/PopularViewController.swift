//  PopularViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class PopularViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var tblPopular: UITableView!{
        didSet{
            self.tblPopular.delegate = self
            self.tblPopular.dataSource = self
            self.tblPopular.register(PopularTableViewCell.nib, forCellReuseIdentifier: PopularTableViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var objMovie: MovieAPIResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular"
        self.getMovies()
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesTrending(withId: 3) { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.tblPopular.reloadData()
                }
            }
        }
    }
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension PopularViewController: UITableViewDelegate & UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMovie?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as? PopularTableViewCell ?? PopularTableViewCell()
        if let popular = objMovie?.movies?[indexPath.row] {
            cell.setPopularView(with: popular )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popularDetail = PopularDetailViewController()
        popularDetail.index = indexPath.row
        popularDetail.objMovie = objMovie
        self.navigationController?.pushViewController(popularDetail, animated: true)
    }
}
