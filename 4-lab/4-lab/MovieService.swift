//
//  MovieService.swift
//  4-lab
//
//  Created by Temirbek Balabek on 4/11/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
class MovieService {
    static let shared = MovieService()
    
    func downloadMovies(page: Int, search: String, completion: @escaping (DownloadFilmsResponse) -> Void) {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=2ed24751&s=\(search)&r=json&page=\(page)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DownloadFilmsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class DownloadFilmsResponse: Codable {
        var movies: [Movie]
        var totalResults: String = ""
        
        enum CodingKeys: String, CodingKey {
            case movies = "Search"
            case totalResults
        }
    }
}
