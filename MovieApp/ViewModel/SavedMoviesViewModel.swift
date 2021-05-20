//
//  SavedMoviesViewModel.swift
//  MovieApp
//
//  Created by Zhaniya  on 30.03.2021.
//

import Foundation
import UIKit
import RealmSwift

protocol SavedMoviesShowing {
    func showFavMovies()
    var cachedMovies: Observable<[CachedMovies]> { get }
}

class SavedMoviesViewModel: SavedMoviesShowing {
    
    var cachedMovies = Observable<[CachedMovies]>([])
    private var realmService = RealmManager()
    
    func showFavMovies() {
        cachedMovies.value = realmService.showFavorites()
    }
    
}

