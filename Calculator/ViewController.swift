//
//  ViewController.swift
//  Calculator
//
//  Created by Mriganka Ghosh on 19/06/16.
//  Copyright © 2016 Mriganka Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var userIsTyping = false
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        let currentDisplay = display.text!
        
        if userIsTyping {
            display.text = currentDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsTyping = true
    }
    
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
}
