//
//  SearchViewController.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 18/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    weak var delegate : ManageControllersDelegate?
    private let movieApi = MovieAPI()
    private var listMovies : [Movie] = [Movie]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionSearch: UICollectionView! {
        didSet{
            self.collectionSearch.register(UINib.init(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionSearch.delegate = self
        collectionSearch.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        searchBar.searchTextField.leftView?.tintColor = .white
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension SearchViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
        if listMovies.count != 0 {
            cell.configMovie(movie: listMovies[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < listMovies.count {
            let storyBoard: UIStoryboard = UIStoryboard(name: "DetailMovies", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DetailMoviesViewController") as! DetailMoviesViewController
            vc.infoMovie = listMovies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let randInt = Int.random(in: 150...450)
        return CGSize(width: (UIScreen.main.bounds.width - 10) / 2, height: CGFloat(randInt))
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let stringSearch = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        print("searchText \(stringSearch)")
        self.movieApi.getSearch(keyword: stringSearch) { listMovies in
            self.listMovies = listMovies
            if listMovies.count > 0 {
                DispatchQueue.main.async {
                    self.collectionSearch.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.listMovies.removeAll()
                    self.collectionSearch.reloadData()
                }
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.listMovies.removeAll()
            self.collectionSearch.reloadData()
        }
    }
}
