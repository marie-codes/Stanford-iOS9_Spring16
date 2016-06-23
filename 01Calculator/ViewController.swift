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
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsTypingANumber = false
        operandStack.append(displayValue)
        print(operandStack)
    }
    
    // displayValue - Computed Property
    // Text on display will be converted from String to Double
    // and double value when set will go as string into the display label
    var displayValue: Double {
        get {
            // return Double(display.text!)!
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTypingANumber = false
        }
    }
    
    // MARK:
    /* FIFTH VERSION *****************************************/
    @IBAction func operateV5(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        // Since performOperation: only has one argument which is a function and it 
        // is the last argument, then we can move the function outside like so;
        // case "×": performOperation({ $0 * $1 }) -> performOperation() { $0 * $1 }
        // and since the method only has no other arguments, we can remove the parenthesis
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default:
            break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    // Compiler Error: Method 'performOperation' with Objective-C selector 'perform: ' conflicts with previous declaration with the same Objective-C selector
    // Objective-C does not support method overloading, you have to use a different method name. When 
    // you inherited UIViewController you inherited NSObject and made the class interopable to Obj-C.
    // To solve I made the methods private to disable inference from @objc, besides these methods should be private anyways.
    // Other ways to solve: 1) remove UIViewController subclass. 2) add @nonobjc to top of the method
    // http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara
    
    
    // MARK:
    /* FIFTH VERSION *****************************************/
    @IBAction func operateV6(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        // We dont need to name the paramenters, therefore
        // case "×": performOperation({ (op1, op2) in op1 * op2 }) becomes
        // case "×": performOperation({ (op1, op2) in $0 * $1 })
        case "×": performOperation({ $0 * $1 })
        //case "÷": performOperation(divide)
        //case "+": ...
        //case "−": ...
        default:
            break
        }
    }
    func performOperationV6(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // MARK:
    /* FOURTH VERSION *****************************************/
    @IBAction func operateV7(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        // From the signature of performOperation: it knows that it takes 2 Doubles, and
        // returns a Double, so we can remove it down here
        case "×": performOperation({ (op1, op2) in op1 * op2 })
        //case "÷": performOperation(divide)
        //case "+": ...
        //case "−": ...
        default:
            break
        }
    }
    func performOperationV7(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // MARK:
    /* THIRD VERSION *****************************************/
    @IBAction func operateV8(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation({ (op1: Double, op2: Double) -> Double in
            return op1 * op2
        }) 
        //case "÷": performOperation(divide)
        //case "+": ...
        //case "−": ...
        default:
            break
        }
    }
    func performOperationV8(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // MARK:
    /* SECOND VERSION *****************************************/
    @IBAction func operateV9(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation(multiply)
        case "÷": performOperation(divide)
        //case "+": ...
        //case "−": ...
        default:
            break
        }
    }
    func performOperationV9(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    func divide(op1: Double, op2: Double) -> Double {
        return op1 / op2
    }
    
    // MARK:
    /* FIRST VERSION *****************************************/
    @IBAction func operateV10(sender: UIButton) {
        let operation = sender.currentTitle!
        
        // When an operation button is pressed add digit to stack without having to press enter
        // i.e., '8' enter '6' enter 'x' becomes '8' enter '6' 'x'
        if userIsTypingANumber {
            enter()
        }
        switch operation {
        case "×":
            if operandStack.count >= 2 {
                displayValue = operandStack.removeLast() * operandStack.removeLast()
                enter()
            }
        case "÷":
            if operandStack.count >= 2 {
                displayValue = operandStack.removeLast() / operandStack.removeLast()
                enter()
            }
        //case "+": ...
        //case "−": ...
        default:
            break
        }
    }

}


