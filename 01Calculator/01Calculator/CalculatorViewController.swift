//
//  CalculatorViewController.swift
//  01Calculator
//
//  Created by Julio Franco on 6/22/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

var calculatorCount = 0

class CalculatorViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()

    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
            // return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    
    private var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded up a new calculator (count = \(calculatorCount))")
        
        // NOTES:
        // Memory cycle
        
        // Adding new operation to the dict in the Model, because of closure the display
        // outlets needs 'self.' and thus creating a strong pointer in the heap??
        // so the closure has a strong pointer to the heap from the Model because it is
        // an operation and those are stored in a dict in the Brain Model, and the display
        // outlet also has a strong pointer to the heap thus creating a memory cycle.
        // You can see by running 1) addUnaryOperation and commenting the other one out
        // that the CalculatorVC is never Deinitialized / Deallocated, because the comment
        // down in 'deinit()' is never called. However with either 2) or 3) it is deallocated
        
        // 1)
//        brain.addUnaryOperation("Z") {
//            self.display.textColor = UIColor.redColor()
//            return sqrt($0)
//        }
        
        // FIX -  2) or 3) :
        // 2)
        brain.addUnaryOperation("Z") { [unowned me = self] in
            me.display.textColor = UIColor.redColor()
            return sqrt($0)
        }
        // 3)
//        brain.addUnaryOperation("Z") { [weak weakSelf = self] in
//            weakSelf?.display.textColor = UIColor.redColor()
//            return sqrt($0)
//        }
    }
    
    deinit {
        calculatorCount -= -1
        print("Calculator left the heap (count = \(calculatorCount))")
    }

}


