//
//  CalculatorBrain.swift
//  CalculatorApp
//
//  Created by Joe Sturzenegger on 4/18/17.
//  Copyright © 2017 Joe Sturzenegger. All rights reserved.
//

import Foundation

struct CalculatorBrain {
  
  private var accumulator: Double?
  private var opList: String?
  
  private enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double,Double) -> Double)
    case equals
    case clear
  }
  

  
  private var operations: Dictionary<String, Operation> = [
    "π": Operation.constant(Double.pi),
    "e": Operation.constant(M_E),
    "√": Operation.unaryOperation(sqrt), 
    "sin": Operation.unaryOperation(sin),
    "cos": Operation.unaryOperation(cos),
    "tan": Operation.unaryOperation(tan),
    "%": Operation.unaryOperation({ $0 * 0.01 }),
    "x^2": Operation.unaryOperation({ $0 * $0 }),
    "±": Operation.unaryOperation({ -$0 }),
    "×": Operation.binaryOperation({ $0 * $1 }),
    "−": Operation.binaryOperation({ $0 - $1 }),
    "+": Operation.binaryOperation({ $0 + $1 }),
    "÷": Operation.binaryOperation({ $0 / $1 }),
    "=": Operation.equals,
    "c": Operation.clear
  ]
  
  mutating func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
      if opList == nil {
        if accumulator != nil {
          opList = "\(accumulator!)"
        }
      }
      switch operation {
      case .constant(let value):
        opList = "\(opList!)\(symbol) "
        accumulator = value
      case .unaryOperation(let function):
        if accumulator != nil {
          opList = "\(symbol)(\(opList!)) "
          accumulator = function(accumulator!)
        }
      case .binaryOperation(let function):
        if accumulator != nil{
          opList = "\(opList!) \(symbol) "
          pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
          accumulator = nil
        }
      case .equals:
        print(opList!)
        performPendingBinaryOperation()
      case .clear:
        opList = nil
        accumulator = 0.0
      }
    }
  }
  
  private mutating func performPendingBinaryOperation() {
    if pendingBinaryOperation != nil && accumulator != nil {
      accumulator = pendingBinaryOperation!.perform(with: accumulator!)
      pendingBinaryOperation = nil
    }
  }
  
  var resultIsPending: Bool {
    get {
      return pendingBinaryOperation != nil
    }
  }
  
  private var pendingBinaryOperation: PendingBinaryOperation?
  
  private struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
      return function(firstOperand, secondOperand)
    }
    
  }
  
  mutating func setOperand(_ operand: Double) {
    accumulator = operand
  }
  
  var result: Double? {
    get {
      return accumulator
    }
  }
}
