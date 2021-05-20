//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Zhaniya  on 16.02.2021.
//

import UIKit
import RealmSwift
import SDWebImage

protocol MoviesSaving {
    func saveButtonTapped(favMovie: CachedMovies)
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmGenre: UILabel!
    @IBOutlet weak var filmImgView: UIImageView!
    @IBOutlet weak var rateAverage: UILabel!
    var savedMovie: CachedMovies!
    var savedMoviesDelegate: MoviesSaving?
    
    let addToFavorites: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = UIColor.white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
        setFavoriteButtonUI()
        addToFavorites.addTarget(self, action: #selector(markFavorite), for: .touchUpInside)
        
    }
    
    func generateNews(movie: CachedMovies) {
        self.filmTitle.text = movie.title
        self.rateAverage.text = String(format: "%.2f", movie.voteAverage)
        self.filmImgView.imageFromUrl(urlString: movie.posterPath)
        self.filmGenre.text = movie.getGenres(filmGenres: movie.genreIDs)
        
    }
    
   @objc func markFavorite() {
        savedMoviesDelegate?.saveButtonTapped(favMovie: savedMovie)
    }
    
 
   // MARK: UI
      
    private func configUI() {
        filmImgView.layer.cornerRadius = 15
        rateAverage.textColor = UIColor.white.withAlphaComponent(0.85)
        rateAverage.layer.borderColor = UIColor.black.cgColor
    }

    
    private func setFavoriteButtonUI() {
    
        addToFavorites.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToFavorites)
        
        addToFavorites.topAnchor.constraint(equalTo: filmImgView.topAnchor, constant: 40).isActive = true
        addToFavorites.trailingAnchor.constraint(equalTo: filmImgView.trailingAnchor, constant: -20).isActive = true
        addToFavorites.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addToFavorites.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
