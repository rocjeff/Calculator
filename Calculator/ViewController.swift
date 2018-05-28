//
//  ViewController.swift
//  Calculator
//
//  Created by Jeffrey Roc on 11/14/17.
//  Copyright © 2017 Jeffrey Roc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numbers(_ number: UIButton) {
        print("number: \(number.tag)")
        if displayingResults || !isNumeric(result.text!) {
            displayingResults = false
            result.text = ""
        }
        result.text = (result.text)! + String(number.tag)
    }
    
    // make sure there is a number on screen and add a decimal 
    @IBAction func decimalPoint(_ decimal: UIButton) {
        print("decimal: \(String(describing: decimal.titleLabel!.text))")
    }
    
    @IBAction func doOperation(_ operation: UIButton) {
        print("operation: \(String(describing: operation.restorationIdentifier))")
        
        // get the operation
        let operationName = String(describing: operation.restorationIdentifier!)
        
        // validate the operation
        if operationName == "" {
            return
        }
        
        if operationName == "equal" {
            if displayingResults || activeOperation == "" {
                return
            }
            
            let currentNumber = result.text == "" || !isNumeric(result.text!) ? 0 : Double(result.text!)!;
            let resultValue = getOperationResult(activeOperation, number1: previousNumber, number2: currentNumber);
            result.text = String(describing: resultValue);
            displayingResults = true
            doingOperation = false
            activeOperation = ""
            previousNumber = 0
          
            print("previousNumber \(previousNumber)")
            print("currentNumber \(currentNumber)")
            return
        }
        
        
        doingOperation = true
        activeOperation = operationName;
        previousNumber = previousNumber != 0 ? previousNumber : (result.text != "" ? Double(result.text!)! : 0)
        displayingResults = false;
        
        print("previousNumber \(previousNumber)")
        
        // get operation symbol
        result.text = getOperationSymbol(operationName)
        
    }
    
    var resultsNumber: Double = 0;
    var previousNumber: Double = 0;
    var activeOperation: String = "";
    var doingOperation: Bool = false;
    var displayingResults: Bool = false;
    
    // gets the symbol of the operation
    func getOperationSymbol(_ operationName: String) -> String {
        switch(operationName) {
        case "plus":
            return "+"
        case "minus":
            return "-"
        case "multiply":
            return "x"
        case "divide":
            return "/"
        default:
            return ""
        }
    }
    
    
    // gets the result of the operation
    func getOperationResult(_ operationName: String, number1: Double, number2: Double) -> Double {
        print("operation: \(operationName) \(String(number1)) \(String(number2))")
        
        switch operationName {
        case "plus":
            return number1 + number2
        case "minus":
            return number1 - number2
        case "multiply":
            return number1 * number2
        case "divide":
            return number1 / number2
        default:
             return 0
        }
    }
    
    func isNumeric(_ characters: String) -> Bool {
        guard characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(characters).isSubset(of: nums)
    }

    @IBAction func clearResult(_ clear: UIButton) {
        result.text = ""
        previousNumber = 0
        activeOperation = ""
        displayingResults = false
        doingOperation = false
    }
    
    @IBOutlet weak var result: UILabel!
    
}

