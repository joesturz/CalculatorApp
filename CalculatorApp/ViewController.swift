//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Joe Sturzenegger on 4/14/17.
//  Copyright © 2017 Joe Sturzenegger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var display: UILabel!
  
  var userIsInTheMiddleOfTyping = false
  var userEnteredDecimal = false
  
  @IBAction func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    } else {
      display.text = digit
      userIsInTheMiddleOfTyping = true
    }
  }
  @IBAction func touchDecimal(_ sender: UIButton) {
    let decimal = sender.currentTitle!
    if userIsInTheMiddleOfTyping && !userEnteredDecimal {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + decimal
      userEnteredDecimal = true
    }
    else {
      if !userEnteredDecimal {
        display.text = "0" + decimal
      }
      userIsInTheMiddleOfTyping = true
    }
  }
  
  var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }
  
  private var brain = CalculatorBrain()
  
  @IBAction func preformOperation(_ sender: UIButton) {
    
    if userIsInTheMiddleOfTyping {
      brain.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    
    if userEnteredDecimal {
      userEnteredDecimal = false
    }
    
    if let mathmaticalSymbol = sender.currentTitle {
      brain.performOperation(mathmaticalSymbol)
    }
    if let result = brain.result {
      displayValue = result
    }
  }
  
}

