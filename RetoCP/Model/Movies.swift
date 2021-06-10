//
//  Movies.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import Foundation

struct Movies: Codable {
    let premieres: [Premiers]
}

struct Premiers: Codable {
    let description: String
    let image: String
}
