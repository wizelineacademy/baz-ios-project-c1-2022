//  NowPlayingViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var tblNowPlay: UITableView!{
        didSet{
            self.tblNowPlay.delegate = self
            self.tblNowPlay.dataSource = self
            self.tblNowPlay.register(NowPlayingTableViewCell.nib, forCellReuseIdentifier: NowPlayingTableViewCell.identifier)
        }
    }
    
    private var objNowPlay: NowPlayingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Now Playing"
        self.getNowPlaying()
    }
    
    //MARK: - S E R V I C E S
    private func getNowPlaying() {
        let movieApi = MovieAPI()
        movieApi.getNowPlaying { [weak self] nowPlayingResponse, error in
            guard let self = self else{ return }
            if nowPlayingResponse != nil {
                self.objNowPlay = nowPlayingResponse
                DispatchQueue.main.async {
                    self.tblNowPlay.reloadData()
                }
            }
        }
    }
}


extension NowPlayingViewController: UITableViewDelegate & UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objNowPlay?.nowPlaying?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.identifier) as? NowPlayingTableViewCell ?? NowPlayingTableViewCell()
        if let nowPlay = objNowPlay?.nowPlaying?[indexPath.row] {
            cell.setInfo(with: nowPlay)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetail = MovieDetailViewController()
        movieDetail.index = indexPath.row
//        movieDetail.objMovie = objMovie
        self.navigationController?.pushViewController(movieDetail, animated: true)
    }
}
