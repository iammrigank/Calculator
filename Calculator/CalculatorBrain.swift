//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mriganka Ghosh on 19/06/16.
//  Copyright © 2016 Mriganka Ghosh. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    var accumulator = 0.0
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in
            return op1 * op2
        }),
        "+" : Operation.BinaryOperation({ (op1, op2) in return op1 + op2 }),
        "-" : Operation.BinaryOperation({ return $0 - $1 }),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    var result : Double {
        get {
            return accumulator
        }
    }
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFuntion: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFuntion(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFuntion: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
}