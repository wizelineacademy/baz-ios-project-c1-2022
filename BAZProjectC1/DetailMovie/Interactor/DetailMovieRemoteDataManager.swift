//
//  DetailMovieRemoteDataManager.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class DetailMovieRemoteDataManager:DetailMovieRemoteDataManagerInputProtocol {
    
    // MARK: - Properties
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol?
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private var selectedLanguage:ApiLanguageResponse {
        if let data = UserDefaults.standard.object(forKey: "SelectedLanguageResponse") as? Data,
            let selectedLanguage = try? JSONDecoder().decode(ApiLanguageResponse.self, from: data) {
              return selectedLanguage
        }else{
            return .es
        }
    }
    
    /**
     Function that calls the 'similar' api https://api.themoviedb.org/3/movie/\{idMovie}/similar
     
     - Parameters:
       - idMovie: An integer value referencing the movie identifier.
     */
    func getMovieSimilar(idMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDay.self, from: data)
                self.remoteRequestHandler?.pushSimilarMoviesData(similarMoviesData: result.results)
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /**
     Function that calls the 'detailMovie' api https://api.themoviedb.org/3/movie/\{idMovie}
     
     - Parameters:
       - idMovie: An integer value referencing the movie identifier.
     */
    func getMovieDetail(idMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                self.remoteRequestHandler?.pushMovieDetailData(movieData: result)
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
