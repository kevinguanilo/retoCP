//
//  Movies.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import Foundation
import ImageSlideshow

struct Movies: Codable {
    let premieres: [Premiers]
}

struct Premiers: Codable {
    let description: String
    let image: String
}

struct MoviesResult {
    let moviesImg: [InputSource]
    let moviesTitle: [String]
}
