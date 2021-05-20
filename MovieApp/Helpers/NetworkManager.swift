//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Zhaniya  on 19.02.2021.
//

import Foundation
import SVProgressHUD

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let apiKey = "e9d942cc8458978df4cb5e687faa1252"
    let baseURL = "https://api.themoviedb.org/3/movie"
    let params = "language=en"
    
    func getMovies(page: Int, completion: @escaping (Result<[Movies]?, Error>) -> Void) {

        guard let url = URL(string: "\(baseURL)/upcoming?api_key=\(apiKey)&\(params)&page=\(page)")
        else { fatalError("Wrong URL") }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let moviesResult = try decoder.decode(MoviesResult.self, from: jsonData)
                    let movies = moviesResult.results
                    completion(.success(movies))
                }
                catch(let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getSimilarMovies(id: Int, completion: @escaping (Result<[Movies]?, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/\(id)/similar?api_key=\(apiKey)&\(params)-US&page=1")
        else { fatalError("Wrong URL") }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if  let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let similarMoviesResult = try decoder.decode(MoviesResult.self, from: jsonData)
                    let similarMovies = similarMoviesResult.results
                    completion(.success(similarMovies))
                }
                catch(let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getVideoTrailer(id: Int, completion: @escaping (Result<[Video]?, Error>) -> Void) {
        
        SVProgressHUD.show()
        
        guard let url = URL(string: "\(baseURL)/\(id)/videos?api_key=\(apiKey)&\(params)-US") else {
            fatalError("Wrong URL") }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let videoTrailerResult = try decoder.decode(VideoResult.self, from: jsonData)
                    let videoTrailers = videoTrailerResult.results
                    print("These are video", videoTrailers)
                    completion(.success(videoTrailers))
                }
                catch(let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
        SVProgressHUD.dismiss()
      }
    }

