//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Zhaniya  on 22.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var moviesForSearch = Observable<[CachedMovies]>([])
    var showingMovies = Observable<[CachedMovies]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        setUpTableView()
    }
    
    @IBAction func search(_ sender: Any) {
        searhMovie(movie: searchTextField)
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
    }
    
    private func searhMovie(movie: UITextField) {
        if let text = movie.text {
            let movies = moviesForSearch.value.filter { movie -> Bool in
                if movie.title.contains(text) {
                    return true
                }
                else {
                    return false
                }
            }
            showingMovies.value = movies
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchToDetails" {
            if let destinationVC = segue.destination as? DetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let movie = showingMovies.value[indexPath.row]
                    destinationVC.movie = movie
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return showingMovies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? SearchMoviesTableViewCell {
            
            let movie = showingMovies.value[indexPath.row]
            cell.populateCell(movieTitle: movie.title, movieRating: String(movie.voteAverage), movieGenre: movie.getGenres(filmGenres: movie.genreIDs), movieImg: movie.posterPath)
            
            return cell
        }   else {
            return UITableViewCell()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "fromSearchToDetails", sender: self)
    }
    
}


extension SearchViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

