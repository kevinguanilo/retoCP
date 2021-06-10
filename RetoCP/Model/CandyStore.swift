//
//  CandyStore.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/10/21.
//

import Foundation

struct CandyStore: Codable {
    let items: [Items]
}

struct Items: Codable {
    let name: String
    let description: String
    let price: String
}
