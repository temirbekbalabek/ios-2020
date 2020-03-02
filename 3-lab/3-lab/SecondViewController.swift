//
//  SecondViewController.swift
//  3-lab
//
//  Created by Temirbek Balabek on 3/2/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createView))
        self.navigationItem.rightBarButtonItem = addButton
    }
    @objc func createView() {
        let vc = ViewController(nibName: nil, bundle: nil)
        vc.nextView.backgroundColor = .red
        vc.nextView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        print("created")
        vc.view.addSubview(vc.nextView)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
