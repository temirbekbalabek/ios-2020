//
//  SecondViewController.swift
//  MidTerm
//
//  Created by Temirbek Balabek on 3/7/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    var onSave: ((UIColor) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func selectColor(_ sender: UIButton) {
        onSave?(sender.backgroundColor!)
        self.navigationController?.popViewController(animated: true)

    }
}
