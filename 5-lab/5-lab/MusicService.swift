//
//  MusicService.swift
//  5-lab
//
//  Created by Temirbek Balabek on 4/29/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import AVFoundation

class MusicService {
    // MARK: - Variables
    static let shared = MusicService()
    var player: AVPlayer?
    var myURL = ""
    // MARK: - Methods
    func searchForMusic(search: String, completion: @escaping (MusicSearchResponse?, Error?) -> ()) {
        let url = URL(string: "https://itunes.apple.com/search?term=\(search)&entity=song")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MusicSearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(response, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    
    func play(track: Track, myURL: String) {
        self.myURL = myURL
        let playerItem: AVPlayerItem
        
        switch isDownloaded(track: track) {
        case true:
//            print("play from file")
            playerItem = .init(url: getFileUrl(for: track, myURL: myURL))
        case false:
//            print("play from url")
            playerItem = .init(url: track.previewUrl)
        }

        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
    }
    func pause(track: Track, myURL: String) {
        let playerItem: AVPlayerItem
                
        switch isDownloaded(track: track) {
        case true:
//            print("play from file")
            playerItem = .init(url: getFileUrl(for: track, myURL: myURL))
        case false:
//            print("play from url")
            playerItem = .init(url: track.previewUrl)
        }
        self.player = AVPlayer(playerItem:playerItem)
//        player?.volume = 1.0
        player?.pause()
        player = nil
        print("SSSSTTTTOOOPPP")
    }
    
    func isDownloaded(track: Track) -> Bool {
        return FileManager.default.fileExists(atPath: getFileUrl(for: track, myURL: self.myURL).path)
    }
    
    func download(track: Track, myURL: String, completion: @escaping (URL?, Error?) -> ()) {
        self.myURL = myURL
        URLSession.shared.downloadTask(with: track.previewUrl) { tempURL, _, error in
            if let tempURL = tempURL {
                do {
                    let url = self.getFileUrl(for: track, myURL: myURL)
                    try FileManager.default.moveItem(at: tempURL, to: url)
                
                    print("successfully downloaded: \(track.trackName)")
                    print("URL", url)
                    DispatchQueue.main.async {
                        completion(url, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func getFileUrl(for track: Track, myURL: String) -> URL {
        var documentsDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        var documentsDirectoryURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        documentsDirectoryURL += myURL
//        print("ASDF", track, "|", track.previewUrl, "|", track.previewUrl.lastPathComponent)
        let url = documentsDirectoryURL.appendingPathComponent(myURL + track.previewUrl.lastPathComponent)
        return url
    }
    
    
    
    // MARK: - Response
    class MusicSearchResponse: Codable {
        var tracks: [Track]
        
        enum CodingKeys: String, CodingKey {
            case tracks = "results"
        }
    }
}
