//
//  Constants.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import Foundation

public enum Endpoints: String {
    case movies = "premieres"
    case candys = "candystore"
    case complete = "complete"
}

struct Api {
    static let BASE_URL = "http://ec2-18-219-76-53.us-east-2.compute.amazonaws.com:8080/cp/v1/"
    
    static let KEY = "5042406e2d9a46f8e330a6b89e997af4"
    static let SCHEME = "https"
    static let HOST = "api.themoviedb.org"
    static let PATH = "/3"
    
    
    static let youtubeThumb = "https://img.youtube.com/vi/"
    static let youtubeLink = "https://www.youtube.com/watch?v="
}
