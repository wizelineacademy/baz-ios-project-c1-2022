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
    var listMoviesSelect: [Movie] = [Movie]()
    var listTypeMovies: [String] = ["Now Playing","Trending", "Popular", "Top Rated", "Upcoming"]
    var firstElementListMoviesSelect: Movie!
    
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
    }
    
    
    func configCollectionView(){
        typeMovieCollection.delegate = self
        typeMovieCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configSelection(index: Int = 0){
        
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
    
    func headerTableView(){
        self.tableHeaderViewHeight = (self.view.frame.height * 0.60)
        self.tblHome.rowHeight = UITableView.automaticDimension
        self.tblHome.estimatedRowHeight = UITableView.automaticDimension
        self.tblHome.showsVerticalScrollIndicator = false
        self.tblHome.dataSource = self
        self.tblHome.delegate = self
        self.configHeaderTableView()
    }
    
    func configHeaderTableView(){
        headerView = (tblHome.tableHeaderView as! HomeHeaderView)
        tblHome.tableHeaderView = nil
        tblHome.addSubview(headerView)
        tblHome.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tblHome.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 0)
        updateHeaderView()
    }
    
    func updateHeaderView(){
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: self.view.frame.width, height: tableHeaderViewHeight)
        
        if tblHome.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tblHome.contentOffset.y
            headerRect.size.height = -tblHome.contentOffset.y + tableHeaderViewCutaway/2
        }
        headerView.frame = headerRect
    }
    
    @IBAction func seeMoreHeader(_ sender: Any) {
        sendDetailMovies(movie: self.firstElementListMoviesSelect)
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.delegate = self
        cell.configCell(listMovies: listMoviesSelect)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
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
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailMoviesViewController") as! DetailMoviesViewController
        newViewController.infoMovie = movie
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
