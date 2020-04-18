//
//  DetailService.swift
//  4-lab
//
//  Created by Temirbek Balabek on 4/13/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation

class DetailService {
    // MARK: - Variables
       static let shared = DetailService()
       
       // MARK: - Methods
       func downloadMovies(id: String, completion: @escaping (DownloadDetailResponse) -> Void) {
           guard let url = URL(string: "http://www.omdbapi.com/?apikey=2ed24751&i=\(id)&r=json") else { return }
        
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
                   let response = try decoder.decode(DownloadDetailResponse.self, from: data)
                   
                   DispatchQueue.main.async {
                       completion(response)
                   }

               } catch {
                   print(error)
               }
           }
           task.resume()
       }
       
       class DownloadDetailResponse: Codable {
        var title: String;
        var year: String;
        var released: String;
        var runtime: String
        var rating:String;
        var genre: String;
        var director: String;
        var writer: String
        var poster: String;
        var actors: String;
           
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case released = "Released"
            case runtime = "Runtime"
            case genre = "Genre"
            case rating = "imdbRating"
            case director = "Director"
            case writer = "Writer"
            case poster = "Poster"
            case actors = "Actors"
        }
    }
}
