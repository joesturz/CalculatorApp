//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Joe Sturzenegger on 4/14/17.
//  Copyright © 2017 Joe Sturzenegger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        label.text = digit
    }

}

