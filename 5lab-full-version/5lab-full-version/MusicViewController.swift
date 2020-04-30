//
//  MusicViewController.swift
//  5lab-full-version
//
//  Created by Temirbek Balabek on 4/30/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sBar: UISearchBar!
    
    var myURL = ""
    // MARK: - Variables
    var tracks: [Track] = []
    
    var onSave: ((Track) -> Void)? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sBar.delegate = self
        sBar.text = "eminem"
        MusicService.shared.searchForMusic(search: sBar.text!) { [weak self] result, error in
            guard let self = self else { return }
            
            if let tracks = result?.tracks {
                self.tracks = tracks
                self.tableView.reloadData()
            } else if let error = error {
                print(error)
            }
        }
    }


}

extension MusicViewController: TrackTableViewCellDelegate {
    
    func didPressPlay(track: Track, myURL: String?) {
        MusicService.shared.play(track: track, myURL: self.myURL)
    }
    func didPressPause(track: Track, myURL: String?) {
        MusicService.shared.pause(track: track, myURL: self.myURL)
    }
    
    func didPressDownload(track: Track, myURL: String?, completion: @escaping (Track) -> ()) {
        MusicService.shared.download(track: track, myURL: self.myURL) { url, error in
            if let url = url {
                completion(track)
                print("a;sdlfkjas;dfla;lskfjsd;lkjf", track)
                print("a;sdlfkjas;dfla;lskfjsd;lkjf")
                print("a;sdlfkjas;dfla;lskfjsd;lkjf")
                self.onSave?(track)
            } else if let error = error {
                print(error)
            }
        }
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath) as! TrackTableViewCell

        if self.tracks.count != 0 {
            cell.track = self.tracks[indexPath.row]
        }
        cell.delegate = self
        
        return cell

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        MusicService.shared.searchForMusic(search: sBar.text!){ [weak self] result, error in
            guard let self = self else { return }
            
            if let tracks = result?.tracks {
                self.tracks = tracks
                self.tableView.reloadData()
            } else if let error = error {
                print(error)
            }
        }
        
    }
}
