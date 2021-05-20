//
//  SimilarMoviesViewController.swift
//  MovieApp
//
//  Created by Zhaniya  on 12.03.2021.
//

import UIKit

class SimilarMoviesViewController: UIViewController {

    //MARK: Properties
    
    var movie: CachedMovies?
    private var viewModel: SimilarMoviesFetching = SimilarMoviesViewModel()
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadSimilarMoviesObservable()
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        viewModel.similarMoviesObservable.addObserver { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    //MARK: Network call
    
    private func loadSimilarMoviesObservable() {
        if let movieID = movie?.id {
            viewModel.getSimilarMovies(id: movieID)
            print(movieID)
        }
    }
}

//MARK: UICollectionView Data Source & Delegate

extension SimilarMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similarMoviesObservable.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMoviesCollectionViewCell", for: indexPath) as! SimilarMoviesCollectionViewCell
        
        let similarMovie = viewModel.similarMoviesObservable.value[indexPath.item]
        cell.generateSimilarMovies(movie: similarMovie)
        return cell
    }
}

