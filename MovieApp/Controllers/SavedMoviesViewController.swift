//
//  SavedMoviesViewController.swift
//  MovieApp
//
//  Created by Zhaniya  on 13.04.2021.
//

import UIKit

class SavedMoviesViewController: UITableViewController {

    private var viewModel = SavedMoviesViewModel()
    private var realmService = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.showFavMovies()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.cachedMovies.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath)
        let savedMovie = viewModel.cachedMovies.value[indexPath.row]
        cell.textLabel?.text = savedMovie.title
        cell.detailTextLabel?.text = String(savedMovie.voteAverage)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSavedToDetails" {
            let destinationVC = segue.destination as! DetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let savedMovie = viewModel.cachedMovies.value[indexPath.row]
            destinationVC.movie = savedMovie
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromSavedToDetails", sender: self)
    }
  
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let movie = viewModel.cachedMovies.value[indexPath.row]
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
//            tableView.reloadData()
//            completionHandler(true)
//        }
//        deleteAction.backgroundColor = .systemBlue
//        realmService.deleteMovie(movie: movie)
//        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
//        swipeAction.performsFirstActionWithFullSwipe = true
//        return swipeAction
//    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
             
             let movie = viewModel.cachedMovies.value[indexPath.row]
             realmService.deleteMovie(movie: movie)
             tableView.deleteRows(at: [indexPath], with: .fade)
             
        }
    }
}
