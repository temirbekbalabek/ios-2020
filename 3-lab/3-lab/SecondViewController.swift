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
    var selectedView: UIView?
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var yField: UITextField!
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValues()
    }
    func setValues() {
        guard let view = selectedView else {return}
        
        self.widthField.text = view.frame.width.description
        self.heightField.text = view.frame.height.description
        self.xField.text = view.frame.origin.x.description
        self.yField.text = view.frame.origin.y.description
        
        buttons.forEach {(button) in
            if button.backgroundColor == view.backgroundColor {
                button.isSelected = true
                return
            } else {
                button.isSelected = false
            }
        }
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
    
    @objc func deleteView(_ sender: UIBarButtonItem) {
        if let view = selectedView {
            view.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func createView(_ sender: UIBarButtonItem) {
        let screenSize = UIScreen.main.bounds
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
                let alert = UIAlertController(title: "Error", message: "Please, make sure you fill in all the fields", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true)
                return
        }

        if CGFloat(w) > screenSize.width || CGFloat(h) > screenSize.height ||
        CGFloat(x) > screenSize.origin.x + screenSize.width ||
        CGFloat(x) > screenSize.origin.x + screenSize.width {
            let alert = UIAlertController(title: "Error", message: "view is outside the screen", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let view = selectedView else {
            onSave?(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h), c)
            return
        }
        
        view.backgroundColor = c
        view.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(w), height: CGFloat(h))
        self.navigationController?.popViewController(animated: true)

        print("pressed", xField.text ?? "", yField.text!, heightField.text!, widthField.text!)
    }

}
