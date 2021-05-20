//
//  CachedMoviesViewModel.swift
//  MovieApp
//
//  Created by Zhaniya  on 07.05.2021.
//

import Foundation
import RealmSwift

protocol CachedMoviesReading {
    var cachedMovies: Observable<[CachedMovies]> { get }
    func loadCachedMovies()
}

class CachedMoviesViewModel {
    
    var cachedMovies = Observable<[CachedMovies]>([])
    private let networkService = NetworkManager()
    private let realmService = RealmManager()
}

extension CachedMoviesViewModel: CachedMoviesReading {
    
    func loadCachedMovies() {
        cachedMovies.value = realmService.readMovies()
    }
}
