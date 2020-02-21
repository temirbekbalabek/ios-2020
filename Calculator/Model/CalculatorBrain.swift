//
//  Calculator.swift
//  Lab 1
//
//  Created by Temirbek Balabek on 2/3/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation

let time = UInt32(NSDate().timeIntervalSinceReferenceDate)

func Rand() -> Double {
   srand48(Int(time))
   let ran: Double = drand48()
   return ran

}
func factorial(value: Double) -> Double {
    let n = value
    if(n == 1){
      return 1
    }else{
        return n * factorial(value:n-1)
    }
}

class CalculatorBrain
{
    var accumulator : Double = 0
    var reminder : Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?

    func setOperand (operand: Double) {
        accumulator = operand
        print(accumulator)
    }
    
    enum Operation {
         case equals
         case constant(value: Double)
         case unary(function: (Double) -> Double)
         case binary(function: (Double, Double) -> Double)
         case clear
     }
     
    
     var map: [String : Operation] = [
         "+" : .binary { $0 + $1 },
         "x" : .binary { $0 * $1 },
         "/" : .binary { $0 / $1 },
         "-" : .binary { $0 - $1 },
         "π": .constant(value: Double.pi),
         "√": .unary{ value in return sqrt(value)},
         "ran": .constant(value: Rand()),
         "%": .unary{$0*0.1},
         "x^y": .binary {pow($0, $1)},
         "=" : .equals,
         "x!" : .unary{ x in return factorial(value: x) },
         "AC" : .clear
     ]
    func performOperand (symbol: String) {
        guard
            let operation = map[symbol]
        else {
            return
        }
    
        switch operation {
            case .constant(let value):
                accumulator = value
            case .unary(let function):
                accumulator = function(accumulator)
            case .binary(let function):
                if lastBinaryOperation != nil {
                    performOperand(symbol: "=")
                }
                lastBinaryOperation = function
                reminder = accumulator
            case .equals:
                if let lastOperation = lastBinaryOperation {
                    accumulator = lastOperation(reminder, accumulator)
                    lastBinaryOperation = nil
                    reminder = 0
                }
            case .clear :
                lastBinaryOperation = nil
                reminder = 0
                accumulator = 0
        }
    }
    var result: Double {
        get {
            return accumulator
        }
    }
}
