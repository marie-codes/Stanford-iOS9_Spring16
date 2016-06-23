//
//  ViewController.swift
//  01Calculator
//
//  Created by Julio Franco on 6/22/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTypingANumber = true
        }
    }

}

