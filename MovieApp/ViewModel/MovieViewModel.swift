//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Zhaniya  on 03.03.2021.
//

import Foundation
import RealmSwift
import SVProgressHUD

protocol MoviesFetching {
    var moviesObservable: Observable<[Movies]> { get }
    func loadMovies()
}

class MoviesViewModel {

    // MARK: Network layer & Realm db
    private let networkService = NetworkManager()
    private let realmService = RealmManager()
    
    
    // MARK: Private
    private var currentPage = 1

    // MARK: Public
    var moviesObservable = Observable<[Movies]>([])
}


//MARK: Movies fetching & writing to Realm DB

extension MoviesViewModel: MoviesFetching {
    
    func loadMovies() {
        networkService.getMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.moviesObservable.value += movies ?? []
                self?.currentPage += 1
                DispatchQueue.main.async {
                    self?.realmService.saveMovies(movies: self?.moviesObservable.value ?? [])
                    NotificationCenter.default.post(name: .sendMovies, object: nil, userInfo: nil)
                    
                }
                // write movies to Realm
                
            case .failure(let error):
                self?.moviesObservable.value = []
                print(error.localizedDescription)
            }
        }
    }
}


