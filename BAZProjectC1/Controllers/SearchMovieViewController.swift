//
//  SearchMovieViewController.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//  NO USAR BUNDLE EN NIB

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var notFoundMovieView: UIView!

    private var categoryMovieTableDataSource: CategoryMovieTableDataSource?
    private var categoryMovieTableDelegate: CategoryMovieTableDelegate?
    private var movies: Movies = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
        movieTableView.register(UINib(nibName: "CategoryMovieTableViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellReuseIdentifier: "CategoryMovieCell")
        categoryMovieTableDelegate = CategoryMovieTableDelegate(using: self)
        categoryMovieTableDataSource = CategoryMovieTableDataSource(with: movies)
        movieTableView.delegate = categoryMovieTableDelegate
        movieTableView.dataSource = categoryMovieTableDataSource
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchMovieByKeyword), for: .editingChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailMovieScreen: DetailMovieViewController = segue.destination as! DetailMovieViewController
        detailMovieScreen.movie = sender as? Movie
    }

    private func setUpInitialView() {
        let paddingView = UIView(frame: CGRect(x: 0.00, y: 0.00, width: 15.00, height: 48.00))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.layer.cornerRadius = 15.00
        searchTextField.attributedPlaceholder = NSAttributedString(string: "What do you search?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "aux100Color") ?? .white])
        searchTextField.becomeFirstResponder()
    }

    private func fetchMovieByPhrase(_ isKeyword: Bool? = false) {
        MovieNetworkManager.shared.fetchMovieByPhrase(isKeyword: isKeyword!, search: searchTextField.text ?? "") { [weak self] objectResponse, error in
            guard let objectResponse = objectResponse,
                  let movies = objectResponse.results else { return }
            self?.movies = movies
            DispatchQueue.main.async {
                self?.categoryMovieTableDataSource?.reloadData(with: movies, using: self?.movieTableView ?? UITableView())
            }
        }
    }

    @objc
    /// This function performs the search for movies according to the letters that the user is entering
    private func searchMovieByKeyword() {
        categoryMovieTableDataSource?.reloadData(with: [], using: movieTableView)
        fetchMovieByPhrase(true)
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchMovieViewController: CategoryMovieCellProtocol {

    func didSelectMovie(_ index: Int) {
        performSegue(withIdentifier: "goDetailMovie", sender: movies[index])
    }
}

// MARK: searchTextField deledate -
extension SearchMovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        categoryMovieTableDataSource?.reloadData(with: [], using: movieTableView)
        searchTextField.resignFirstResponder()
        fetchMovieByPhrase()
        return true
    }
}
