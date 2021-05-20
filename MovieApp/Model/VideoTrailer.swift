//
//  VideoTrailer.swift
//  MovieApp
//
//  Created by Zhaniya  on 07.05.2021.
//

import Foundation

struct VideoResult: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable {
    let key: String 
}
