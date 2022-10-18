//
//  MoviesViewController.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var tableHeaderViewHeight: CGFloat = UIScreen.main.bounds.height
    private let tableHeaderViewCutaway: CGFloat = 0
    
    private var headerView: HomeHeaderView!
    private var listMoviesSelect: [Movie] = [Movie]()
    private var recentlyWatchedMovies: [Movie] = [Movie]()
    private var listTypeMovies: [String] = ["Now Playing","Trending", "Popular", "Top Rated", "Upcoming"]
    private var firstElementListMoviesSelect: Movie!
    
    @IBOutlet weak var contentTableView: UIView!
    @IBOutlet weak var tblHome: UITableView! {
        didSet{
            tblHome.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        }
    }
    
    @IBOutlet weak var typeMovieCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTableView()
        configCollectionView()
        configSelection()
        suscribeObserverToNotificationCenter()
    }
    
    private func suscribeObserverToNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRecentMovie), name: NSNotification.Name(rawValue: "notification.addRecentMovieHome"), object: nil)
    }
    
    private func configCollectionView(){
        typeMovieCollection.delegate = self
        typeMovieCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if !recentlyWatchedMovies.isEmpty {
            tblHome.reloadData()
        }
    }
    
    @objc private func addRecentMovie(_ notification: NSNotification){
        if let recentMovie = notification.userInfo?["recentMovie"] as? Movie {
            if !recentlyWatchedMovies.contains(where: { $0.id == recentMovie.id }) {
                recentlyWatchedMovies.append(recentMovie)
                recentlyWatchedMovies.reverse()
            }
        }
    }
    
    private func configSelection(index: Int = 0){
        
        switch index {
        case 0:
            listMoviesSelect = appDelegate.listMoviesNowPlaying
        case 1:
            listMoviesSelect = appDelegate.listMoviesTrending
        case 2:
            listMoviesSelect = appDelegate.listMoviesPopular
        case 3:
            listMoviesSelect = appDelegate.listMoviesTopRated
        case 4:
            listMoviesSelect = appDelegate.listMoviesUpcoming
        default:
            listMoviesSelect = appDelegate.listMoviesTrending
        }
        
        if let firstElementListMoviesSelect = listMoviesSelect.first {
            self.firstElementListMoviesSelect = firstElementListMoviesSelect
            listMoviesSelect.removeFirst()
            headerView.setImage(movie: firstElementListMoviesSelect)
            self.tblHome.reloadData()
            let indexPath = IndexPath(item: index , section: 0)
            typeMovieCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    private func headerTableView(){
        self.tableHeaderViewHeight = (self.view.frame.height * 0.60)
        self.tblHome.rowHeight = UITableView.automaticDimension
        self.tblHome.estimatedRowHeight = UITableView.automaticDimension
        self.tblHome.showsVerticalScrollIndicator = false
        self.tblHome.dataSource = self
        self.tblHome.delegate = self
        self.configHeaderTableView()
    }
    
    private func configHeaderTableView(){
        headerView = (tblHome.tableHeaderView as! HomeHeaderView)
        tblHome.tableHeaderView = nil
        tblHome.addSubview(headerView)
        tblHome.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tblHome.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 0)
        updateHeaderView()
    }
    
    private func updateHeaderView(){
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: self.view.frame.width, height: tableHeaderViewHeight)
        
        if tblHome.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tblHome.contentOffset.y
            headerRect.size.height = -tblHome.contentOffset.y + tableHeaderViewCutaway/2
        }
        headerView.frame = headerRect
    }
    
    @IBAction private func seeMoreHeader(_ sender: Any) {
        sendDetailMovies(movie: self.firstElementListMoviesSelect)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        navController.modalTransitionStyle = .crossDissolve
        self.present(navController, animated: true, completion: nil)
    }
    
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !recentlyWatchedMovies.isEmpty ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !recentlyWatchedMovies.isEmpty && indexPath.row == 0 {
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.delegate = self
            cell.listMovies = self.recentlyWatchedMovies
            cell.containerSize = CGSize(width: 350, height: 250)
            cell.configCell(title: "Vistas Recientemente", typeCell: .recentlywatched)
            return cell
        }else{
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.delegate = self
            cell.listMovies = self.listMoviesSelect
            cell.configCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !recentlyWatchedMovies.isEmpty && indexPath.row == 0 {
            return 300.0
        }else{
            return 400.0
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTypeMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFilterTypeMovie", for: indexPath) as! FilterTypeMovieCollectionViewCell
        cell.lblTitleTypeMovie.text = listTypeMovies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item <= listTypeMovies.count {
            self.configSelection(index: indexPath.item)
        }
    }
}

extension MoviesViewController: ManageControllersDelegate {
    func sendDetailMovies(movie: Movie) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DetailMovies", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailMoviesViewController") as! DetailMoviesViewController
        vc.infoMovie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
