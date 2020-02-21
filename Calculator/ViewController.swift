//
//  ViewController.swift
//  Calculator
//
//  Created by Temirbek Balabek on 2/1/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var brain = CalculatorBrain()
    var corrector = false
    
    
    @IBAction func numbersClicked(_ sender: UIButton) {
        guard
            let digit = sender.titleLabel?.text
            else { return }
        if corrector || labelView.text == "0" || labelView.text == "0.0" {
            labelView.text = ""
        }
        corrector = false
        labelView.text?.append(digit)
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let operation = sender.titleLabel?.text,
            let numberText = labelView?.text,
            let number = Double(numberText)
        else { return }
        brain.setOperand(operand: number)
        brain.performOperand(symbol: operation)
        labelView.text = "0"
        if operation == "=" {
            labelView.text = "\(brain.accumulator)"
            corrector = true
        }
        if operation == "π" || operation == "%" ||  operation == "√" || operation == "x!" {
            labelView.text = "\(brain.accumulator)"
        }

    }
}

