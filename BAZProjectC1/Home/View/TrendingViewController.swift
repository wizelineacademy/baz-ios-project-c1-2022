//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final class TrendingViewController: UITableViewController {
    lazy var searchBar:UISearchBar = UISearchBar()
    @IBOutlet weak var principalTabBar: UITabBarItem!
    private let viewModel = TrendingMovieViewModel()
    var notificationCenterHelper: TextoResponsivo = TextoResponsivo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        setupView()
        setSearchBar()
        notificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: NSNotification.Name(rawValue: "responsiveText.Notification"))
    }
    
    /// This method registers the table and adds a gesture
    func setupView(){
        tableView.register(UINib.init(nibName: SearchTableViewCell.reuseIdentifier, bundle: Bundle(for: SearchTableViewCell.self)), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
                view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    /// This method Called when the iOS interface environment changes and register an notification center
    /// - Parameters:
    /// - previousTraitCollection: The UITraitCollection object before the interface environment changed.
    ///
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
             
             notificationCenterHelper.myNotificationCenter.post(name: NSNotification.Name(rawValue: "responsiveText.Notification"), object: nil, userInfo: nil)
         }
    }
    
    /// This method is executed when a notification is received
    /// - Parameters:
    /// - notification: An object containing information broadcast to registered observers
    
    @objc private func notificationReceived(_ notification: NSNotification) {
        searchBar.searchTextField.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    /// This method adds a searchbar for searh movies by title or author
    func setSearchBar(){
        searchBar.searchTextField.font = .boldSystemFont(ofSize: 20 /*: 16*/)
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    /// This method get trendingMovies

    func getMovies(){
        self.view.showAnimation()
        viewModel.getMovies(.trendingMovie)
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.view.hideAnimation()
            }
        }
    }
    
    /// This method searches movies from a given text
    /// - Parameters:
    /// - text: The text to search
    
    func searchMovie(with text: String){
        self.view.showAnimation()
        viewModel.getMovies(.search(text: text))
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.view.hideAnimation()
            }
        }
    }
    
    /// This recognizes one or many taps for searchbar
    
    @objc func tapGestureHandler() {
        searchBar.endEditing(true)
    }
    
    /// Tells this object that one or more new touches occurred in a view or window
    /// - Parameters:
    /// - touches: set of UITouch instances that represent the touches.
    /// - event:  The event to which the touches belong.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(data: viewModel.movieDataArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as! SearchTableViewCell
        cell.setSelected(true, animated: true)
        let object = viewModel.movieDataArray[indexPath.item]
        let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        vc.movieSelected = object
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TrendingViewController: UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) { }
    
    ///This method received search-related information from the user
    ///- Parameters:
    ///- searchbar: an object for searchbar type.
    ///- searchText: The text changed
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
        let searchText = trimmedString.replacingOccurrences(of: " ", with: "%20")
        if searchText.count > 1 {
            searchMovie(with: searchText)
        } else {
            getMovies()
        }
        
    }
}
