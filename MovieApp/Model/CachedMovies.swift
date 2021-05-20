//
//  CachedMovies.swift
//  MovieApp
//
//  Created by Zhaniya  on 08.04.2021.
//

import Foundation
import RealmSwift

class CachedMovies: Object {
    
    let genreIDs = List<Int>()
    @objc dynamic var overview = ""
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var title = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var id = 0
    @objc dynamic var saved = false
    
    override class func primaryKey() -> String? {
        return "title"
    }
    
    func getGenres(filmGenres:List<Int>) -> String {

           let stringGenres = filmGenres.map { (genre) -> String in

                   switch genre {
                   case 28:
                       return "action"
                   case 12:
                       return "adventure"
                   case 16:
                       return "animation"
                   case 35:
                       return "comedy"
                   case 80:
                       return "crime"
                   case 99:
                       return "documentary"
                   case 18:
                       return "drama"
                   case 10751:
                       return "family"
                   case 14:
                       return "fantasy"
                   case 36:
                       return "history"
                   case 27:
                       return "horror"
                   case 10402:
                       return "music"
                   case 9648:
                       return "mystery"
                   case 10749:
                       return "romance"
                   case 878:
                       return "science fiction"
                   case 10770:
                       return "tv movie"
                   case 53:
                       return "thriller"
                   case 10752:
                       return "war"
                   case 37:
                       return "western"
                   default: return ""
                   }
               }.sorted().joined(separator: "  ")
               return stringGenres
           }
}
