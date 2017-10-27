//
//  ViewController.swift
//  CalculatorPractice
//
//  Created by Chao Kuan-Hao on 30/09/2017.
//  Copyright © 2017 Chao Kuan-Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsCurrentlyTyping = false;
    
    var displayValue: Double{                   // the variable of the number in the UILabel
        get{
            return Double(UILabel.text!)!
        }
        set{
            UILabel.text = String(newValue)     // what is new
        }
    }


    @IBAction func UIButtonNumber(_ sender: UIButton) {
        let numberOnButton = sender.currentTitle!
        print("\(numberOnButton) is pressed")
        if userIsCurrentlyTyping{
            let textCUrrentlyDisplay = UILabel.text!
            UILabel.text = textCUrrentlyDisplay + numberOnButton
        }
        else{
            userIsCurrentlyTyping = true
            UILabel.text = numberOnButton
        }
    }
    
    private var method = CalcuatorBrain()

    @IBOutlet weak var UILabel: UILabel! = nil

    @IBAction func Operand(_ sender: UIButton) {
        if userIsCurrentlyTyping{
            method.setOperand(displayValue);       // send string to the setOperand function
            userIsCurrentlyTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            method.performOperation(mathematicalSymbol)
        }
        if let result = method.result{
            displayValue = result
        }

}
}

