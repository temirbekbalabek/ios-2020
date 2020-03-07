//
//  ViewController.swift
//  MidTerm
//
//  Created by Temirbek Balabek on 3/7/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var selectedButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func viewSelected(_ sender: UIButton) {
        selectedButton = sender
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
        else { return }
        selectVC.onSave = { (color) in
            self.selectedButton?.backgroundColor = color

        }
        self.navigationController?.pushViewController(selectVC, animated: true)

    }
    
}

