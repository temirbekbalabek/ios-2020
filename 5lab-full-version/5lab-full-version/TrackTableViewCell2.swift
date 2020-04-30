//
//  TrackTableViewCell2.swift
//  5lab-full-version
//
//  Created by Temirbek Balabek on 4/30/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

protocol TrackTableViewCell2Delegate: class {
    func didPressPlay(track: Track)
    func didPressPause(track: Track, myURL: String?)
}

class TrackTableViewCell2: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    // MARK: - Variables
    var track: Track! {
        didSet {
            self.nameLabel.text = track.trackName
            self.artistLabel.text = track.artistName
        }
    }
    var delegate: TrackTableViewCell2Delegate?
    
    // MARK: - Actions
    @IBAction func play(_ sender: Any) {
        delegate?.didPressPlay(track: track)
    }
    @IBAction func pause(_ sender: Any) {
           delegate?.didPressPause(track: track, myURL: nil)
    }
}
