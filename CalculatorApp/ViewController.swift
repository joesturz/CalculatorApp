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
    
    if let mathmaticalSymbol = sender.currentTitle {
      brain.performOperation(mathmaticalSymbol)
    }
    if let result = brain.result {
      displayValue = result
    }
  }
  
}

