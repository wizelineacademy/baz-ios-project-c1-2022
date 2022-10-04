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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        setupView()
        setSearchBar()
        registraNotificacionTeclado()
    }
    
    func setupView(){
        tableView.register(UINib.init(nibName: SearchTableViewCell.reuseIdentifier, bundle: Bundle(for: SearchTableViewCell.self)), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
                view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func setSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
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
    
    func registraNotificacionTeclado (){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidHideNotification, object: nil)

    }
   
    @objc func tapGestureHandler() {
        searchBar.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
            if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                debugPrint("Notification: Keyboard will show")
                
                view.endEditing(true)
            }
        }
    
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
        let searchText = trimmedString.replacingOccurrences(of: " ", with: "%20")
        if searchText.count > 1 {
            searchMovie(with: searchText)
        }
        
    }
}
