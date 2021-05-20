//
//  SimilarMoviesViewModel.swift
//  MovieApp
//
//  Created by Zhaniya  on 17.03.2021.
//

import Foundation

protocol SimilarMoviesFetching {
    var similarMoviesObservable: Observable<[Movies]> { get }
    func getSimilarMovies(id: Int)
}

class SimilarMoviesViewModel  {
    
    //MARK: Network layer
    
    private let networkManager = NetworkManager()
 
    //MARK: Public
    
    var similarMovies = [Movies]()
    var similarMoviesObservable = Observable<[Movies]>([])
    
}

    //MARK: Protocol

extension SimilarMoviesViewModel: SimilarMoviesFetching {
    
    func getSimilarMovies(id: Int) {
        networkManager.getSimilarMovies(id: id) { [weak self] result in
            switch result {
            case .success(let similarMovies):
                self?.similarMoviesObservable.value = similarMovies ?? []
            
            case .failure:
                self?.similarMoviesObservable.value = []
            }
        }
    }
}

