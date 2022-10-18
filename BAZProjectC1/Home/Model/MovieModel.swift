//
//  MovieModel.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 30/09/22.
//

struct MoviesResponse: Decodable {
    let results: [MovieData]
}

struct MovieData: Decodable {
    let id: Int?
    let title: String?
    let name: String?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case name
        case overview
        case posterPath = "poster_path"
    }
}

struct MovieModel {
    var movieObject = [TableViewMovieCellModel (sectionFilter: "", posters: [[PosterCollectionCell(posterImage: "", title: "", overView: "")]])]
    
    mutating func setupMovie(section: TableViewMovieCellModel){
        self.movieObject.append(section)
    }
    
    mutating func removeAllMovie(){
        self.movieObject.removeAll()
    }
}
