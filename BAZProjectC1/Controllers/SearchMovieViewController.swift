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

    private var movies: Movies = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
        movieTableView.register(UINib(nibName: "CategoryMovieTableViewCell", bundle: Bundle(for: HomeMovieViewController.self)), forCellReuseIdentifier: "CategoryMovieCell")
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchMovieByKeyword), for: .editingChanged)
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
            DispatchQueue.main.async { [weak self] in
                self?.movieTableView.reloadData()
            }
        }
    }

    @objc
    /// This function performs the search for movies according to the letters that the user is entering
    private func searchMovieByKeyword() {
        fetchMovieByPhrase(true)
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: searchTextField deledate -
extension SearchMovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        fetchMovieByPhrase()
        return true
    }
}

// MARK: TableView's DataSource
extension SearchMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieCell", for: indexPath) as! CategoryMovieTableViewCell
        MovieNetworkManager.shared.downloadImage(imagePath: movies[indexPath.row].poster_path ?? "", width: 200) { [weak self] image in
            DispatchQueue.main.async {
                movieCell.titleMovieLabel.text = self?.movies[indexPath.row].title ?? self?.movies[indexPath.row].name ?? "No Title"
                movieCell.posterMovie.image = image ?? UIImage(named: "poster")
            }
        }
        return movieCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        114.00
    }
}

// MARK: TableView's Delegate
extension SearchMovieViewController: UITableViewDelegate {

}
