//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Zhaniya  on 24.02.2021.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper
import SVProgressHUD

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Properties
   
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var detailFilmTitle: UILabel!
    @IBOutlet weak var detailReleaseDate: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailPopularity: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var similarMoviesLabel: UILabel!
    private var viewModel: VideoTrailersFetching = VideoTrailersViewModel()
    var movie: CachedMovies?
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            populateDetails()
            makeRoundCorners()
            getVideoTrailer()
            bindViewModel()
           
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSimilarMovies" {
            let destinationVC = segue.destination as! SimilarMoviesViewController
            destinationVC.movie = movie
        }
    }
        
private func populateDetails() {
            
    if let movie = movie {
        detailFilmTitle.text = movie.title
        detailReleaseDate.text = movie.releaseDate.formattedDateFromString(dateString: movie.releaseDate, withFormat: "dd.MM.YYYY")
        detailRating.text = String(format: "%.2f", movie.voteAverage)
        detailPopularity.text = String(format: "%.2f", movie.popularity)
        detailOverview.text = movie.overview
        
    }
        }
    
    private func getVideoTrailer() {
        SVProgressHUD.show()
        if let movieID = movie?.id {
            viewModel.getVideoTrailers(id: movieID)
        }
        SVProgressHUD.dismiss()
    }
    
    private func setUpPlayer() {
        let videoCode = viewModel.trailers.value.first?.key
        print("Here's code:", videoCode ?? "")
        youtubePlayer.load(withVideoId: videoCode ?? "", playerVars: ["playsinline":"1"])
    }
    
    private func bindViewModel() {
        viewModel.trailers.addObserver { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUpPlayer()
            }
        }
    }
    
   // MARK: UI
    
   private func makeRoundCorners() {
        view1.layer.cornerRadius = 15.0
        view2.layer.cornerRadius = 15.0
        view3.layer.cornerRadius = 15.0
    }
}


