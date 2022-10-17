//  MovieCategoryTableViewController.swift
//  BAZProjectC1
//  Created by 291732 on 17/10/22.

import UIKit

class MovieCategoryTableViewController: UITableViewController {
    
    //MARK: - V A R I A B L E S
    private var objMovie: MovieAPIResponse?
    let movieCategory: MovieCategory
    
    init(movieCategory: MovieCategory) {
        self.movieCategory = movieCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieCategory.title
        self.getMovies()
        tableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.register(NowPlayingTableViewCell.nib, forCellReuseIdentifier: NowPlayingTableViewCell.identifier)
        tableView.register(PopularTableViewCell.nib, forCellReuseIdentifier: PopularTableViewCell.identifier)
        tableView.register(TopRatedTableViewCell.nib, forCellReuseIdentifier: TopRatedTableViewCell.identifier)
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesCategory(on: movieCategory ) { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - TableView's DataSource
extension MovieCategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objMovie?.movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch movieCategory {
        case .trending:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell ?? MovieTableViewCell()
            if let movie = objMovie?.movies?[indexPath.row] {
                cell.setInfoTrading(with: movie)
            }
            return cell
            
        case .nowPlaying:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.identifier) as? NowPlayingTableViewCell ?? NowPlayingTableViewCell()
            if let nowPlay = objMovie?.movies?[indexPath.row] {
                cell.setInfo(with: nowPlay)
            }
            return cell
            
        case .popular:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as? PopularTableViewCell ?? PopularTableViewCell()
            if let popular = objMovie?.movies?[indexPath.row] {
                cell.setPopularView(with: popular )
            }
            return cell
            
        case .topRated:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as? TopRatedTableViewCell ?? TopRatedTableViewCell()
            if let topRated = objMovie?.movies?[indexPath.row]{
                cell.setTopRated(with: topRated)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        if let movie = objMovie?.movies?[indexPath.row] {
            detail.movie = movie
        }
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch movieCategory {
        case .trending:
            return 250
        case .nowPlaying:
            return 200
        case .popular:
            return 300
        case .topRated:
            return 280
        case .upcoming:
            return tableView.estimatedRowHeight
        case .search:
            return tableView.estimatedRowHeight
        }
    }
}
