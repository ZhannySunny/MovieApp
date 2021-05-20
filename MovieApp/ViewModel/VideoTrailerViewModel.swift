//
//  VideoTrailerViewModel.swift
//  MovieApp
//
//  Created by Zhaniya  on 10.05.2021.
//

import Foundation
import SVProgressHUD

protocol VideoTrailersFetching {
    var trailers: Observable<[Video]> { get }
    func getVideoTrailers(id: Int)
}

class VideoTrailersViewModel: VideoTrailersFetching {
    
    var trailers = Observable<[Video]>([])
    private let networkManager = NetworkManager()
    
    func getVideoTrailers(id: Int) {
        //SVProgressHUD.show()
        networkManager.getVideoTrailer(id: id) { [weak self] result in
            switch result {
            case .success(let video):
                self?.trailers.value = video ?? []
            case .failure(let error):
                print("Can't fetch video trailers", error.localizedDescription)
        }
    }
        //SVProgressHUD.dismiss(withDelay: 30)
  }
}
