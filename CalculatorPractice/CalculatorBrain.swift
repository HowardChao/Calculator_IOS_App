//
//  CalculatorBrain.swift
//  CalculatorPractice
//
//  Created by Chao Kuan-Hao on 30/09/2017.
//  Copyright © 2017 Chao Kuan-Hao. All rights reserved.
//

import Foundation


struct CalcuatorBrain{
    
    
    private var accumulation: Double?               //this is the parameter to store the calculation
    
    mutating func setOperand( _ operand: Double ){
        accumulation = operand
    }
    
    private enum Operation{                 //set up a type to document the operation
        case constant (Double)
        case unaryOperation ((Double) -> Double)
        case binaryOperation ( (Double, Double) -> Double)
        case equals         //to hold the situation of the binaryOperation
    }
    
    
    private var operations: Dictionary<String, Operation> = [
    "π": Operation.constant (Double.pi),
    "e": Operation.constant (M_E),
    "√": Operation.unaryOperation(sqrt),
    "cos": Operation.unaryOperation(cos),
    "sin": Operation.unaryOperation(sin),
    "±": Operation.unaryOperation({-$0}),
    "+": Operation.binaryOperation({$0 + $1}),
    "-": Operation.binaryOperation({$0 - $1}),
    "×": Operation.binaryOperation({$0 * $1}),
    "÷": Operation.binaryOperation({$0 / $1}),
    "AC": Operation.constant(0),
    "=": Operation.equals
        
    ]
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{  // we pass a string into the function. The type of operation is
            switch operation{
            case .constant(let value):
                accumulation = value
            case .unaryOperation(let function):
                if accumulation != nil{                     // if when you use unaryoperation without the value inside
                                                            //the accumulation, do nothing.
                    accumulation = function(accumulation!)
                }
            case .binaryOperation(let function):
                if accumulation != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulation!)
                    accumulation = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulation != nil{
            accumulation = pendingBinaryOperation!.perform(with: accumulation!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?       // the value of the pendingBinaryOperation can be nil or have value.
    
    private struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform ( with /*the external variable*/ secondOperand: Double) -> Double{
            return function( firstOperand, secondOperand )
        }
    }
    
    mutating func settingOperation(_ operand: Double){
        accumulation = operand
    }
    var result: Double?{
        get{
            return accumulation
        }
    }
    
}
