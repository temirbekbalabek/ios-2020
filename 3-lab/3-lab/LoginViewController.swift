//
//  LoginViewController.swift
//  3-lab
//
//  Created by Temirbek Balabek on 3/2/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginTapped(_ sender: Any) {
        navigateToMainInterface()
    }
    private func navigateToMainInterface() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(identifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        present(mainNavigationVC, animated: true, completion: nil)
    }
}
