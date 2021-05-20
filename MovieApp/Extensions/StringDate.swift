//
//  StringDate.swift
//  MovieApp
//
//  Created by Zhaniya  on 17.05.2021.
//

import Foundation

extension String {
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        return outputFormatter.string(from: date)
        }
        return nil
    }
}
