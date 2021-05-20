//
//  RealmManager.swift
//  MovieApp
//
//  Created by Zhaniya  on 08.04.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
init() {
   realmConfiguration()
  }

  func realmConfiguration() {
            let config = Realm.Configuration(schemaVersion: 1) { _, oldSchemaVersion in
                    switch oldSchemaVersion {
                    case 1:
                        break
                    default:
                        break
                    }
            }
            Realm.Configuration.defaultConfiguration = config
     }
    
  func saveMovies(movies:[Movies]) {
         
       do {
          let realm = try! Realm()
          try realm.write {
          movies.forEach { (movie) in
              let movieRealm = CachedMovies()
              movieRealm.id = movie.id ?? 0
              movieRealm.title = movie.title ?? ""
              movieRealm.voteAverage = movie.voteAverage ?? 0.0
              movieRealm.releaseDate = movie.releaseDate ?? ""
              movieRealm.overview = movie.overview ?? ""
              movieRealm.popularity = movie.popularity ?? 0.0
              movieRealm.posterPath = movie.posterPath ?? ""
              movieRealm.genreIDs.append(objectsIn: movie.genreIDs ?? [])
              realm.add(movieRealm, update: .modified)
          }
          }
      }
      catch {
          print("Error. Can't write to Realm Database", error.localizedDescription)
          }
  }
    
  func readMovies() -> [CachedMovies] {
        
        var cachedMovies: [CachedMovies] = []
     do {
        let realm = try Realm()
        let result = realm.objects(CachedMovies.self).sorted(byKeyPath: "voteAverage", ascending: false)
            result.forEach { movie in
            cachedMovies.append(movie)
            print(cachedMovies)
        }
    }
      catch {
        print("Error. Can't read data from Realm DB", error.localizedDescription)
     }
        return cachedMovies
    }
    
  func showFavorites() -> [CachedMovies] {
        let realm = try! Realm()
        let favorites = Array(realm.objects(CachedMovies.self).filter("saved == true").sorted(byKeyPath: "voteAverage", ascending: false))
        return favorites
    }
    
    
  func deleteMovie(movie: CachedMovies) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(movie)
    }
}
}
    
    


