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
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let name: String?
    let originalLanguage: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case name
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
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
