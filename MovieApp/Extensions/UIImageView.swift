//
//  Extensions.swift
//  MovieApp
//
//  Created by Zhaniya  on 20.02.2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
        
   func imageFromUrl(urlString: String) {
        
      let baseURL = "https://image.tmdb.org/t/p/w500"
         guard let finalUrl = URL(string: "\(baseURL)/\(urlString)") else {
                return
            }
            self.sd_setImage(with: finalUrl, placeholderImage: UIImage(named: "placeholder")) { (downloadedImage, error, cacheType, url) in
            self.image = downloadedImage
        }
    }
}

