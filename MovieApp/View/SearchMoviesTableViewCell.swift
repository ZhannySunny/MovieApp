//
//  SearchMoviesTableViewCell.swift
//  MovieApp
//
//  Created by Zhaniya  on 25.04.2021.
//

import UIKit
import SDWebImage

class SearchMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieImgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    movieImgView.layer.cornerRadius = 15.0
        
    }

    func populateCell(movieTitle: String, movieRating: String, movieGenre: String, movieImg: String) {
        
        self.movieTitle.text = movieTitle
        self.movieRating.text = movieRating
        self.movieGenre.text = movieGenre
        self.movieImgView.imageFromUrl(urlString: movieImg)
    
}
}
