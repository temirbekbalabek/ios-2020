//
//  DetailViewController.swift
//  4-lab
//
//  Created by Temirbek Balabek on 4/13/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailPoster: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailYear: UILabel!

    @IBOutlet weak var detailReleased: UILabel!
    @IBOutlet weak var detailRuntime: UILabel!

    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailGenre: UILabel!
    @IBOutlet weak var detailDirector: UILabel!
    @IBOutlet weak var detailWriter: UILabel!
    @IBOutlet weak var detailActors: UILabel!
    var id: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    func getInfo() {
        DetailService.shared.downloadMovies(id: id) { response in
            
            self.detailTitle.text = response.title
            self.detailYear.text = response.year
            self.detailReleased.text = response.released
            self.detailRuntime.text = response.runtime
            self.detailGenre.text = response.genre
            self.detailRating.text = response.rating
            self.detailDirector.text = response.director
            self.detailWriter.text = response.writer
            self.detailActors.text = response.actors
            
            ImageService.shared.downloadImage(url: response.poster) { image in
                self.detailPoster.image = image
            }
        }
    }
    
    
    
}
