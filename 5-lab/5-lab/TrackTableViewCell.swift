//
//  TrackTableViewCell.swift
//  5-lab
//
//  Created by Temirbek Balabek on 4/29/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

protocol TrackTableViewCellDelegate: class {
    func didPressPlay(track: Track, myURL: String?)
    func didPressDownload(track: Track, myURL: String?, completion: @escaping (Track) -> ())
}

class TrackTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    // MARK: - Variables
    var track: Track! {
        didSet {
            self.nameLabel.text = track.trackName
            self.artistLabel.text = track.artistName
            
            let isDownloaded = MusicService.shared.isDownloaded(track: self.track)
            
            downloadButton.isUserInteractionEnabled = !isDownloaded
            downloadButton.isHidden = isDownloaded
        }
    }
    var delegate: TrackTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func play(_ sender: Any) {
        delegate?.didPressPlay(track: track, myURL: nil)
    }
   
    
    
    
    @IBAction func download(_ sender: Any) {
        delegate?.didPressDownload(track: track, myURL: nil) { track in
            self.track = track
        }
    }
}
