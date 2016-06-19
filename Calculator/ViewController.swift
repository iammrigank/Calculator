//
//  ViewController.swift
//  Calculator
//
//  Created by Mriganka Ghosh on 19/06/16.
//  Copyright © 2016 Mriganka Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel?
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        let currentDisplay = display!.text!
        
        if currentDisplay != "0" {
            display!.text = currentDisplay + digit
        } else {
            display!.text = digit
        }
    }
}

