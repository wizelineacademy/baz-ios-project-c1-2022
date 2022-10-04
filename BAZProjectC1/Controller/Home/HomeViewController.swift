//  HomeViewController.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import UIKit

final class HomeViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet private weak var tblSearch: UITableView!{
        didSet{
            self.tblSearch.delegate = self
            self.tblSearch.dataSource = self
            self.tblSearch.register(SimpleSearchTableViewCell.nib, forCellReuseIdentifier: SimpleSearchTableViewCell.identifier)
        }
    }

    //MARK: - V A R I A B L E S
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchEmpty : Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchEmpty
    }
    private var objSearch: SearchAPIResult?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
    }
    
    //MARK: - F U N C T I O N S
    private func configureSearchController(){
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.searchTextField.tag = 666
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Pelicula"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: - S E R V I C E S
    private func searchMovie(with str:String) {
        let movieApi = MovieAPI()
        movieApi.searchMovie(with: str) { [weak self] searchResponse, error in
            guard let self =  self else { return }
            if searchResponse != nil {
                self.objSearch = searchResponse
                DispatchQueue.main.async {
                    self.tblSearch.reloadData()
                }
            }
        }
    }
}

// MARK: - EXT -> UI · T A B L E · V I E W · D E L E G A T E
extension HomeViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objSearch?.search?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleSearchTableViewCell.identifier, for: indexPath) as? SimpleSearchTableViewCell ?? SimpleSearchTableViewCell()
        cell.lblTitle.text = objSearch?.search?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = objSearch?.search?[indexPath.row].id
        let reviewDetail = ReviewViewController()
        reviewDetail.idMovie = movieID
        self.navigationController?.pushViewController(reviewDetail, animated: true)
    }
}


// MARK: - EXT -> S E A T C H · R E S U L T · U P D A T I N G
extension HomeViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {

    }
}


extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txt = textField.text { self.searchMovie(with: txt) }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" { return true }
        ///Podemos descomentar esta linea para poder buscar la pelicula hasta el 4to Caracter
//        if (textField.text?.count ?? 0) >= 4 {self.searchMovie(with: textField.text ?? "")  }
        searchMovie(with: textField.text ?? "")
        return true
    }
}
