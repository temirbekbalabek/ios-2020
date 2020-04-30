//
//  ViewController.swift
//  5-lab
//
//  Created by Temirbek Balabek on 4/29/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var ts: [Track] = []
    var myURL = ""
    @IBOutlet weak var tView: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tView.reloadData()
        viewDirectoryInfo()
    }
    @objc func createFolder(_ sender: Any) {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        myURL += "/New1"
        let documentDirectorPath = mainPath + myURL
        var ojeCtBool: ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: documentDirectorPath, isDirectory: &ojeCtBool)
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: documentDirectorPath, withIntermediateDirectories: true, attributes: nil)
                print("created")
            }
            catch {
                print("error")
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        else { return }
        self.navigationController?.pushViewController(selectVC, animated: true)

        
    }
    func viewDirectoryInfo() {
        let fm = FileManager.default
        var path = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
        path += self.myURL
        do {
            let items = try fm.contentsOfDirectory(atPath: path)

            for item in items {
                print("Found \(item)")
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }
    @objc func addMusic(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "MusicViewController") as? MusicViewController
        else { return }
        selectVC.onSave = { [weak self] (track) in
            guard let self = self else { return }
            self.ts.append(track)
            print("3333333333333", track.artistName, self.ts)
            self.tView.reloadData()
        }
        selectVC.myURL = self.myURL
        print("Shymkent Temirbek")
        self.navigationController?.pushViewController(selectVC, animated: true)

    }
}
extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
    }
}
extension ViewController: TrackTableViewCell2Delegate {
    func didPressPause(track: Track, myURL: String?) {
        MusicService.shared.pause(track: track, myURL: self.myURL)
    }
    
    func didPressPlay(track: Track) {
        MusicService.shared.play(track: track, myURL: self.myURL)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track2", for: indexPath) as! TrackTableViewCell2

        if self.ts.count != 0 {
            cell.track = self.ts[indexPath.row]
            print(cell.track.artistName, "555555:")
        }
        cell.delegate = self
        
        return cell
    }
    
    
}
