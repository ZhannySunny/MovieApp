//
//  ViewController.swift
//  MovieApp
//
//  Created by Zhaniya  on 16.02.2021.
//

import UIKit
import RealmSwift

class MoviesViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    let refresher = UIRefreshControl()
    
    private var viewModel: MoviesFetching = MoviesViewModel()
    private var viewModelCache: CachedMoviesReading = CachedMoviesViewModel()
    private var realmService = RealmManager()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
        addRefresher()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetails" {
            if let detailVC = segue.destination as?  DetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let movie = viewModelCache.cachedMovies.value[indexPath.row]
                    detailVC.movie = movie
                }
            }
        }
        
        if segue.identifier == "toSearch" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.moviesForSearch.value = viewModelCache.cachedMovies.value
            }
        }
    }
    
    private func loadData() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadCachedMovies), name: .sendMovies, object: nil)
        viewModel.loadMovies()
    }
    
    @objc func loadCachedMovies() {
        viewModelCache.cachedMovies.value = realmService.readMovies()
        tableView.reloadData()
    }
    
    
    @IBAction func searchMovie(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSearch", sender: self)
    }
    
    private func addRefresher() {
        refresher.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        self.tableView.refreshControl = refresher
    }
    
    @objc func refreshData(sender: UIRefreshControl) {
        viewModel.loadMovies()
        sender.endRefreshing()
    }
}

//MARK: UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModelCache.cachedMovies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "moviesMainInfo", for: indexPath) as? MovieTableViewCell {
            
            let movie = viewModelCache.cachedMovies.value[indexPath.row]
            cell.generateNews(movie: movie)
            cell.savedMoviesDelegate = self
            cell.addToFavorites.setImage(UIImage(systemName: (movie.saved) ? "heart.fill" : "heart"), for: .normal)
            cell.savedMovie = movie
            return cell
          }
        return UITableViewCell()
    }
}


// MARK: UITableViewDelegate, Pagination

extension MoviesViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.loadMovies()
        }
    }
}


extension MoviesViewController: MoviesSaving {
   
    func saveButtonTapped(favMovie: CachedMovies) {
        let realm = try! Realm()
        let movie = realm.objects(CachedMovies.self).filter("title == %@", favMovie.title).first
        try! realm.write {
            movie!.saved = !favMovie.saved
        }
        tableView.reloadData()
    }
}
