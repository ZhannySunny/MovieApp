//
//  SimilarMoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Zhaniya  on 08.03.2021.
//

import UIKit
import SDWebImage

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    func generateSimilarMovies(movie: Movies) {
        self.movieImgView.imageFromUrl(urlString: movie.posterPath ?? "")
        self.movieRating.text = String(format: "%.2f", movie.voteAverage ?? "0.0")
        self.movieTitle.text = movie.title
        
    }
    
}
