//
//  Services.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import Foundation
import ImageSlideshow

class Services {
    
    var session = URLSession.shared
    
    static func getMovies(endpoint: Endpoints, completion: @escaping (MoviesResult?) -> Void) {
        let baseURL = URL(string: Api.BASE_URL)
        guard let url = baseURL?.appendingPathComponent(endpoint.rawValue) else { completion(nil); return }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let requestURL = components?.url else { completion(nil) ; return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error \(error.localizedDescription)")
                completion (nil)
                return
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                let movieResults = try JSONDecoder().decode(Movies.self, from: data)
                var imageMovies: [InputSource] = []
                var titleMovies: [String] = []
                for movie in movieResults.premieres {
                    imageMovies.append(ImageFromURL(urlString: movie.image, placeholder:  UIImage(named: "cineplanet-logo"))!)
                    titleMovies.append(movie.description)
                }
                completion(MoviesResult(moviesImg: imageMovies, moviesTitle: titleMovies))
            } catch {
                print("There was an error with searching: \(error.localizedDescription)")
                
                completion(nil)
                return
            }
            }.resume()
    }
    
}

struct MoviesResult {
    let moviesImg: [InputSource]
    let moviesTitle: [String]
}
