//
//  ViewController.swift
//  4-lab
//
//  Created by Temirbek Balabek on 4/9/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var sBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(downloadMovies), for: .valueChanged)
        
        return view
    }()
    
    // MARK: - Variables
    var movies: [Movie] = []
    var page: Int = 1
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        sBar.delegate = self
        sBar.text = "monster"
        tableView.refreshControl = refreshControl
        downloadMovies(page: page, search: sBar.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController" {
               if let indexpath = tableView.indexPathForSelectedRow {
                   let detailVC = segue.destination as! DetailViewController
                   detailVC.id = movies[indexpath.row].id
               }
            
        }
            
    }
    // MARK: - Actions
    @objc func downloadMovies(page: Int, search: String) {
        MovieService.shared.downloadMovies(page: page, search: search) { response in
            self.movies += response.movies
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()

        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        cell.movie = self.movies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = movies.count - 1
        if indexPath.row == lastItem {
            page += 1
            downloadMovies(page: page, search: sBar.text!)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        downloadMovies(page: page, search: sBar.text!)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false

        // Remove focus from the search bar.
        searchBar.endEditing(true)
        downloadMovies(page: page, search: sBar.text!)
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
}
