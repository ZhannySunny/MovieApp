//
//  Movies.swift
//  MovieApp
//
//  Created by Zhaniya  on 19.02.2021.
//

import Foundation
import UIKit

struct MoviesResult: Codable {
    let page: Int
    let results: [Movies]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movies: Codable {
    let genreIDs: [Int]?
    let overview: String?
    let voteAverage: Double?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let popularity: Double?
    let id: Int?
    var isFavorite = false 

    enum CodingKeys: String, CodingKey {
        case genreIDs = "genre_ids"
        case overview
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity
        case id 
    }
   }
    

    
    
    
    

    
    


