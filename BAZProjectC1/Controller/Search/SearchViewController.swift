//  SearchViewController.swift
//  BAZProjectC1
//  Created by 291732 on 28/09/22.

import UIKit

final class SearchViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet private weak var tblSearch: UITableView!{
        didSet{
            self.tblSearch.delegate = self
            self.tblSearch.dataSource = self
            self.tblSearch.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        }
    }
    
    private let wizelineBlue: UIColor = UIColor(red: 12/255, green: 24/255, blue: 35/255, alpha: 1)
    private let arrTitles: [String] = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
    var dctDataSource: [String:Any]?
    private var objMovie: MovieAPIResponse?
    private var objNowPlay: NowPlayingAPIResponse?
    private var objPupular: PopularAPIResponse?
    private var objTopRated: TopRatedAPIResponse?
    private var objUpcoming: UpcomingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllServices()
    }
    
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesTrending { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                DispatchQueue.main.async {
                    self.objMovie = moviesResponse
                }
            }
        }
    }

    private func getNowPlaying() {
        let movieApi = MovieAPI()
        movieApi.getNowPlaying { [weak self] nowPlayingResponse, error in
            guard let self = self else{ return }
            if nowPlayingResponse != nil {
                
                DispatchQueue.main.async {
                    self.objNowPlay = nowPlayingResponse
                }
            }
        }
    }
    
    private func getPopular(){
        let movie_WS = MovieAPI()
        movie_WS.getPopular { [weak self] popularResponse, error in
            guard let self = self else{ return }
            if popularResponse != nil {
                self.objPupular = popularResponse
                DispatchQueue.main.async {
                    self.tblSearch.reloadData()
                }
            }
        }
    }
    
    private func getTopRated(){
        let movie_WS = MovieAPI()
        movie_WS.getTopRated { [weak self] topRatedResponse, error in
            guard let self = self else{ return }
            if topRatedResponse != nil {
                self.objTopRated = topRatedResponse
                DispatchQueue.main.async {
                    self.tblSearch.reloadData()
                }
            }
        }
    }
    
    private func getUpcoming(){
        let movie_WS = MovieAPI()
        movie_WS.getUpcomgin { [weak self] upcomingResponse, error in
            guard let self = self else{ return }
            if upcomingResponse != nil {
                self.objUpcoming = upcomingResponse
                DispatchQueue.main.async {
                    self.tblSearch.reloadData()
                }
            }
        }
    }
    
    private func getAllServices(){
        self.getMovies()
        self.getNowPlaying()
        self.getPopular()
        self.getTopRated()
        self.getUpcoming()
        dctDataSource = createDicFromObjects()
    }
    
    private func createDicFromObjects() -> [String: Any]{
        return ["trending": objMovie as Any,
                "nowPlaying":objNowPlay as Any,
                "popular": objPupular as Any,
                "topRated": objTopRated as Any,
                "upcoming": objUpcoming as Any]
    }
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension SearchViewController: UITableViewDelegate & UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return arrTitles.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat { 70 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell ?? SearchTableViewCell()
        cell.dctDataSource = self.dctDataSource
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrTitles[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        returnedView.backgroundColor = wizelineBlue
        let label = UILabel(frame: CGRect(x: 8, y: 25, width: view.frame.size.width, height: 45))
        label.textColor = .white
        label.font.withSize(35)
        label.text = self.arrTitles[section]
        returnedView.addSubview(label)
        return returnedView
    }
}
