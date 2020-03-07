//
//  SecondViewController.swift
//  3-lab
//
//  Created by Temirbek Balabek on 3/2/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    var onSave: ((CGFloat, CGFloat, CGFloat, CGFloat, UIColor) -> Void)? = nil
    var color: UIColor?
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var yField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createView))
        self.navigationItem.rightBarButtonItem = addButton
    }
    @IBAction func colorChoose(_ sender: UIButton) {
        self.color = sender.backgroundColor
        sender.isSelected = true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
    }
    @objc func createView(_ sender: UIBarButtonItem) {
        guard
            let xText = xField.text,
            let yText = yField.text,
            let widthText = widthField.text,
            let heightText = heightField.text
            else { return }
        guard
            let x = Double(xText),
            let y = Double(yText),
            let w = Double(widthText),
            let h = Double(heightText),
            let c = self.color
        else {
                let alert = UIAlertController(title: "404!", message: "Please, make sure you fill in all the fields", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true)
                return
        }

        onSave?(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h), c)
        self.dismiss(animated: true)
        print("pressed", xField.text ?? "", yField.text!, heightField.text!, widthField.text!)
    }
}
